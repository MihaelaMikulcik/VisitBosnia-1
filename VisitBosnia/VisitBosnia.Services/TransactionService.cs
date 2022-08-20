using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class TransactionService:BaseCRUDService<Model.Transaction, Database.Transaction, object, TransactionInsertRequest, object>, ITransactionService
    {
        public TransactionService(VisitBosniaContext context, IMapper mapper):base(context, mapper)
        {

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
            Context.Set<EventOrder>().Add(eventOrder);
            Context.SaveChanges();
            var transaction = new Transaction
            {
                EventOrderId = eventOrder.Id,
                ChargeId = request.ChargeId!,
                Date = DateTime.Now,
                Status = request.Status!,
            };
            Context.Set<Transaction>().Add(transaction);
            Context.SaveChanges();
            return Mapper.Map<Model.Transaction>(transaction);
        }

    }
}
