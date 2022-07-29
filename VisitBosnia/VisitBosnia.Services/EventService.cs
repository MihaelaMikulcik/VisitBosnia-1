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
                filteredQuery = filteredQuery.Where(x => x.Name.ToLower().StartsWith(search.SearchText.ToLower()));
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

            if (search?.IncludeCity == true)
            {
                query = query.Include("City");
            }

            if (search?.IncludeCategory == true)
            {
                query = query.Include("Category");
            }

            return query;
        }

      
    }
}
