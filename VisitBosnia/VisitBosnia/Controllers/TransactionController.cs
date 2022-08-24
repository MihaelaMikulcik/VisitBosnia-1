using Microsoft.AspNetCore.Mvc;
using Stripe;
using System.Net;
using VisitBosnia.Filters;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class TransactionController:BaseCRUDController<Model.Transaction, TransactionSearchObject, TransactionInsertRequest, object>
    {
        ITransactionService _transactionService;
        private readonly IConfiguration _configuration;
        IEventService _eventService;
        public TransactionController(ITransactionService service, IConfiguration config, IEventService eventService):base(service)
        {
            _transactionService = service;
            _configuration = config;
            _eventService = eventService;
        }

        private Token stripeToken;
        private TokenService tokenService;


        [HttpPost]
        [Route("ProcessTransaction")]
        public IActionResult ProcessTransaction(TransactionInsertRequest transaction)
        {
            if (!_eventService.IsAvailableEvent(transaction.EventId, transaction.Quantity))
                throw new UserException("Sorry, event tickets are currently sold out!");
            try
            {
                //return BadRequest("Event tickets are sold out!");

                var token = CreateStripeToken(transaction.creditCard);
                if (token != null)
                {
                    if (CreateCharge(transaction) == true)
                        return Ok("Successful payment");
                    else
                        return StatusCode(500);
                }
                return StatusCode(500);
            }
            catch (Exception ex)
            {
                if (ex is StripeException)
                {
                    //throw new UserException("Your credit card information is not valid!", HttpStatusCode.BadRequest);
                    //return BadRequest("Payment failed!");

                    var stripeErr = ex as StripeException;
                    if (stripeErr.StripeError.Code == "invalid_expiry_year" || stripeErr.StripeError.Code == "invalid_expiry_month")// ili expired_card
                    {
                        //return BadRequest("Your credit card is expired");
                        throw new UserException("Sorry, your credit card is expired...");
                    }
                    else if (stripeErr.StripeError.Code == "incorrect_cvc")// ili expired_card
                    {
                        //return BadRequest("Your credit card is expired");
                        throw new UserException("Error, card's security code is incorrect");
                    }
                    else if (stripeErr.StripeError.Code == "incorrect_number")// ili expired_card
                    {
                        //return BadRequest("Your credit card is expired");
                        throw new UserException("Error, credit card number is incorrect");
                    }
                    else
                    {
                        throw new UserException("Payment failed...");
                    }
                }
                return StatusCode(500);
            }

        }

        //public async Task<bool> isAvailableEvent(int eventId, int newParticipants)
        //{
        //    //var event = _eventService.GetById(eventId);
        //    var Event = await _eventService.GetById(eventId);
        //    var numberOfParticipants = _eventService.GetNumberOfParticipants(eventId);
        //    if (Event != null)
        //    {
        //        if (Event.MaxNumberOfParticipants == numberOfParticipants)
        //            return false;
        //        else if (numberOfParticipants + newParticipants > Event.MaxNumberOfParticipants)
        //            return false;
        //        else
        //            return true;
        //    }
        //    return false;

        //}



        private string CreateStripeToken(CreditCardData creditCard)
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

        private bool CreateCharge(TransactionInsertRequest request)
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
                var transaction = _transactionService.Insert(request);
                return charge != null ? true : false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

       



    }
}
