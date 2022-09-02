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
    public class TransactionController : BaseCRUDController<Model.Transaction, TransactionSearchObject, TransactionInsertRequest, object>
    {
        ITransactionService _service;
      
        public TransactionController(ITransactionService service ) : base(service)
        {
            _service = service;
          
        }

        [HttpPost]
        [Route("ProcessTransaction")]
        public async Task<Model.Transaction?> ProcessTransaction(TransactionInsertRequest transaction)
        {
            return await _service.ProcessTransaction(transaction);
        }

       

    }
}
