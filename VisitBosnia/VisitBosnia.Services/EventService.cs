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

            if (search?.CategoryId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.IdNavigation.CategoryId == search.CategoryId);
            }
            if (search?.CityId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.IdNavigation.CityId == search.CityId);
            }
            if (search?.AgencyId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.AgencyId == search.AgencyId);
            }
            if (search?.AgencyMemberId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.AgencyMemberId == search.AgencyMemberId);
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

        public async Task<int> GetNumberOfParticipants(int eventId)
        {
            var entity = Context.Set<Services.Database.Event>().AsQueryable();
            entity = entity.Include("EventOrders");
            var model = await entity.Where(x => x.Id == eventId).FirstOrDefaultAsync();
            if (model!=null && model.EventOrders.Count() > 0)
            {
                var participants = 0;
                foreach (var eventOrder in model!.EventOrders)
                {
                    participants += eventOrder.Quantity;
                }
                return participants;
            }
            else
                return 0;

        }

        

    }
}
