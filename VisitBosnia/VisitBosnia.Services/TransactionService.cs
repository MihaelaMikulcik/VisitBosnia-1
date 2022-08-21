using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class TransactionService:BaseCRUDService<Model.Transaction, Database.Transaction, TransactionSearchObject, TransactionInsertRequest, object>, ITransactionService
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
                //query = query.Include("EventOrder.Event.AgencyMember");
                //query = query.Include("IdNavigation");
            }
            return query;
        }

    }
}
