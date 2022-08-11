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
    public class TouristFacilityService : BaseCRUDService<Model.TouristFacility, Database.TouristFacility, TouristFacilitySearchObject, TouristFacilityInsertRequest, TouristFacilityUpdateRequest>, ITouristFacilityService
    {

        public TouristFacilityService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<TouristFacility> AddInclude(IQueryable<TouristFacility> query, TouristFacilitySearchObject search = null)
        {

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

        public override IQueryable<TouristFacility> AddFilter(IQueryable<TouristFacility> query, TouristFacilitySearchObject search = null)
        {
            if (search?.Id != 0 && search?.Id != null)
            {
                query = query.Where(x=> x.Id == search.Id);
            }

            return query;
        }

        public override async Task<Model.TouristFacility> GetById(int id)
        {
            var entity = Context.Set<Services.Database.TouristFacility>().AsQueryable();

            entity = entity.Include("City");
            entity = entity.Include("Category");

            var model = entity.Where(x => x.Id == id).FirstOrDefault();

            return Mapper.Map<Model.TouristFacility>(model);
        }

    }
}
