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
    public class EventOrderService:BaseCRUDService<Model.EventOrder, Database.EventOrder, EventOrderSearchObject, EventOrderInsertRequest, object>, IEventOrderService
    {
        public EventOrderService(VisitBosniaContext context, IMapper mapper):base(context, mapper)
        {

        }

        public override IQueryable<EventOrder> AddFilter(IQueryable<EventOrder> query, EventOrderSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (search.EventId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.EventId == search.EventId);
            }
            if (search.AgencyMemberId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Event.AgencyMember.Id == search.AgencyMemberId);
            }

            return filteredQuery;
        }

        public override IQueryable<EventOrder> AddInclude(IQueryable<EventOrder> query, EventOrderSearchObject search = null)
        {
            if (search.IncludeAppUser != null && search.IncludeAppUser == true)
            {
                query = query.Include("AppUser");
            }
            return query;
        }
    }
}
