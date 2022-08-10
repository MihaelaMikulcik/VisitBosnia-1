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
    public class AgencyService : BaseCRUDService<Model.Agency, Database.Agency, AgencySearchObject, AgencyInsertRequest, AgencyUpdateRequest>, IAgencyService
    {

        public AgencyService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Agency> AddFilter(IQueryable<Agency> query, AgencySearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrEmpty(search?.SearchText))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.ToLower().StartsWith(search.SearchText.ToLower()) || x.Address.ToLower().StartsWith(search.SearchText.ToLower()) || x.City.Name.ToLower().StartsWith(search.SearchText.ToLower()));
            }

            return filteredQuery;
        }
        public override IQueryable<Agency> AddInclude(IQueryable<Agency> query, AgencySearchObject search = null)
        {
            if (search.IncludeCity == true)
            {
                query = query.Include("City");
            }
            return query;
        }

    }
}
