using Microsoft.AspNetCore.Mvc;
using Stripe;
using VisitBosnia.Filters;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class TransactionController:BaseCRUDController<Model.Transaction, object, TransactionInsertRequest, object>
    {
        ITransactionService transactionService;
        private readonly IConfiguration configuration;
        public TransactionController(ITransactionService service, IConfiguration config):base(service)
        {
            transactionService = service;
            configuration = config;
        }

        private Token stripeToken;
        private TokenService tokenService;


        [HttpPost]
        [Route("ProcessTransaction")]
        public IActionResult ProcessTransaction(TransactionInsertRequest transaction)
        {
            try
            {
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
                    return BadRequest("Payment failed!");
                    //var stripeErr = ex as StripeException;
                    //if (stripeErr.StripeError.Code == "invalid_expiry_year")
                    //{
                    //    return BadRequest("Your credit card is expired");
                    //    //throw new UserException("Sorry, your credit card is expired...");
                    //}
                }
                return StatusCode(500);
            }

        }



        private string CreateStripeToken(CreditCardData creditCard)
        {
            try
            {
                StripeConfiguration.ApiKey = (configuration["Stripe:PublishableKey"]);
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
                StripeConfiguration.ApiKey = (configuration["Stripe:SecretKey"]);
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
                var transaction = transactionService.Insert(request);
                return charge != null ? true : false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

       



    }
}
