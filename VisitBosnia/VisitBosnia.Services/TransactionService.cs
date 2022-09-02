using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Stripe;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Filters;

using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class TransactionService:BaseCRUDService<Model.Transaction, Database.Transaction, TransactionSearchObject, TransactionInsertRequest, object>, ITransactionService
    {
        private readonly IEventService _eventService;
        private readonly IConfiguration _configuration;
        private Token stripeToken;
        private TokenService tokenService;

        public TransactionService(VisitBosniaContext context, IMapper mapper, IEventService eventService, IAppUserService appUserService,IConfiguration configuration) : base(context, mapper)
        {
            _eventService = eventService;
            _configuration = configuration;

        }

        public override async Task<Model.Transaction> Insert(TransactionInsertRequest request)
        {
            var eventOrder = new EventOrder
            {
                AppUserId = request.AppUserId,
                EventId = request.EventId,
                Price = request.Price,
                Quantity = request.Quantity,
            };
            await Context.Set<EventOrder>().AddAsync(eventOrder);
            await Context.SaveChangesAsync();
            var transaction = new Transaction
            {
                EventOrderId = eventOrder.Id,
                ChargeId = request.ChargeId!,
                Date = DateTime.Now,
                Status = request.Status!,
            };
            await Context.Set<Transaction>().AddAsync(transaction);
            await Context.SaveChangesAsync();
            return Mapper.Map<Model.Transaction>(transaction);
        }
        public override IQueryable<Transaction> AddFilter(IQueryable<Transaction> query, TransactionSearchObject search = null)
        {
            if(search?.AppUserId != null)
            {
                query = query.Where(x => x.EventOrder.AppUserId == search.AppUserId);
            }
            if (!string.IsNullOrEmpty(search?.Status))
            {
                query = query.Where(x => x.Status.ToLower().Equals(search.Status.ToLower()));
            }
            return query;
        }

        public override IQueryable<Transaction> AddInclude(IQueryable<Transaction> query, TransactionSearchObject search = null)
        {
            if(search?.IncludeEventOrder == true)
            {
                query = query.Include("EventOrder");
                query = query.Include("EventOrder.Event");
                query = query.Include("EventOrder.Event.IdNavigation");
                query = query.Include("EventOrder.Event.IdNavigation.City");
                query = query.Include("EventOrder.Event.Agency");
                query = query.Include("EventOrder.Event.AgencyMember");
            
            }
            return query;
        }

        public async Task<Model.Transaction?> ProcessTransaction(TransactionInsertRequest transaction)
        {
            if (!_eventService.IsAvailableEvent(transaction.EventId, transaction.Quantity))
                throw new UserException("Sorry, event tickets are currently sold out!");
            if(!_eventService.isValidDate(transaction.EventId))
                throw new UserException("Sorry, this event has already passed!");
            try
            {
                var token = CreateStripeToken(transaction.creditCard);
                if (token != null)
                {
                    var transactionResult = await CreateCharge(transaction);
                    if (transactionResult!=null)
                        return transactionResult;
                    else
                        return null;
                }
                return null;
            }
            catch (Exception ex)
            {
                if (ex is StripeException)
                {

                    var stripeErr = ex as StripeException;
                    if (stripeErr!.StripeError.Code == "invalid_expiry_year" || stripeErr.StripeError.Code == "invalid_expiry_month")
                    {
                        throw new UserException("Sorry, your credit card is expired...");
                    }
                    else if (stripeErr.StripeError.Code == "incorrect_cvc" || stripeErr.StripeError.Code == "incorrect_number")
                    {
                        throw new UserException("Error, credit card data is not valid!");
                    }
                    else
                    {
                        throw new UserException("Sorry, we couldn't proceed your payment...");
                    }
                }
                else
                {
                    throw new UserException("Payment failed...");
                }
               
            }

        }


        private string CreateStripeToken(Model.CreditCardData creditCard)
        {
            try
            {
                StripeConfiguration.ApiKey = (_configuration["Stripe:PublishableKey"]);
                var chargeService = new ChargeService();
                var options = new TokenCreateOptions
                {
                    Card = new TokenCardOptions
                    {
                        ExpYear = creditCard.ExpYear,
                        ExpMonth = creditCard.ExpMonth,
                        Number = creditCard.Number,
                        Cvc = creditCard.Cvc
                    }
                };
                tokenService = new TokenService();
                stripeToken = tokenService.Create(options);
                return stripeToken.Id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private async Task<Model.Transaction?> CreateCharge(TransactionInsertRequest request)
        {
            try
            {
                StripeConfiguration.ApiKey = (_configuration["Stripe:SecretKey"]);
                
                var options = new ChargeCreateOptions
                {
                    Amount = Convert.ToInt64(request.Price * 100),
                    Currency = "BAM",
                    Source = stripeToken.Id,
                    Description = "Payment for \"" + request.Description + "\" event",
                };
                var service = new ChargeService();
                Charge charge = service.Create(options);
                request.ChargeId = charge.Id;
                request.Status = charge.Status.ToLower();
                var transaction = await Insert(request);
                return charge != null ? transaction : null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
