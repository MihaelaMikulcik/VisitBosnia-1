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
    public class CityService : BaseCRUDService<Model.City, Database.City, CitySearchObject, CityInsertRequest, CityUpdateRequest>, ICityService
    {

        public CityService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<City> AddFilter(IQueryable<City> query, CitySearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrEmpty(search?.SearchText))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.ToLower().StartsWith(search.SearchText.ToLower())/* || x.County.ToLower().StartsWith(search.SearchText.ToLower()) || x.ZipCode.ToLower().StartsWith(search.SearchText.ToLower())*/);
            }


            //if (!string.IsNullOrEmpty(search?.County))
            //{
            //    filteredQuery = filteredQuery.Where(x => x.County.ToLower().StartsWith(search.County.ToLower()));
            //}

            //if (!string.IsNullOrEmpty(search?.ZipCode))
            //{
            //    filteredQuery = filteredQuery.Where(x => x.ZipCode.ToLower().StartsWith(search.ZipCode.ToLower()));
            //}

            return filteredQuery;
        }

    }
}
