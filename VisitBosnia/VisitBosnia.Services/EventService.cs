using AutoMapper;
using Microsoft.EntityFrameworkCore;
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
    public class EventService : BaseCRUDService<Model.Event, Database.Event, EventSearchObject, EventInsertRequest, EventUpdateRequest>, IEventService
    {

        public EventService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Event> AddFilter(IQueryable<Event> query, EventSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);


            if (!string.IsNullOrEmpty(search?.SearchText))
            {
                filteredQuery = filteredQuery.Where(x => x.IdNavigation.Name.ToLower().StartsWith(search.SearchText.ToLower()));
            }


            return filteredQuery;
        }

        public override IQueryable<Event> AddInclude(IQueryable<Event> query, EventSearchObject search = null)
        {
            if(search?.IncludeAgency == true)
            {
                query = query.Include("Agency");
            }

            if (search?.IncludeAgencyMember == true)
            {
                query = query.Include("AgencyMember");
            }

            if (search?.IncludeIdNavigation == true)
            {
                query = query.Include("IdNavigation");
                query = query.Include("IdNavigation.City");
                query = query.Include("IdNavigation.Category");

            }

            return query;
        }

        public override async Task<Model.Event> GetById(int id)
        {

            var entity = Context.Set<Services.Database.Event>().AsQueryable();

            entity = entity.Include("IdNavigation");
            entity = entity.Include("IdNavigation.City");
            entity = entity.Include("IdNavigation.Category");

            var model = entity.Where(x => x.Id == id).FirstOrDefault();

            return Mapper.Map<Model.Event>(model);
        }

    }
}
