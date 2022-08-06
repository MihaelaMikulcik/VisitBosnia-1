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
    public class AttractionService : BaseCRUDService<Model.Attraction, Database.Attraction, AttractionSearchObject, AttractionInsertRequest, AttractionUpdateRequest>, IAttractionService
    {

        public AttractionService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Attraction> AddFilter(IQueryable<Attraction> query, AttractionSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);


            if (!string.IsNullOrEmpty(search?.SearchText))
            {
                filteredQuery = filteredQuery.Where(x => x.IdNavigation.Name.ToLower().StartsWith(search.SearchText.ToLower()));
            }


            return filteredQuery;
        }

        public override IQueryable<Attraction> AddInclude(IQueryable<Attraction> query, AttractionSearchObject search = null)
        {
            if (search?.IncludeIdNavigation == true)
            {
                query = query.Include("IdNavigation");
                query = query.Include("IdNavigation.City");
                query = query.Include("IdNavigation.Category");

            }

            return query;

        }

        public override async Task<Model.Attraction> GetById(int id)
        {
            var entity = Context.Set<Services.Database.Attraction>().AsQueryable();

            entity = entity.Include("IdNavigation");
            entity = entity.Include("IdNavigation.City");
            entity = entity.Include("IdNavigation.Category");

            var model = entity.Where(x => x.Id == id).FirstOrDefault();

            return Mapper.Map<Model.Attraction>(model);
        }


    }
}
