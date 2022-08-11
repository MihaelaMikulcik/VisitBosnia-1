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
    public class AppUserFavouriteService : BaseCRUDService<Model.AppUserFavourite, Database.AppUserFavourite, AppUserFavouriteSearchObject, AppUserFavouriteInsertRequest, AppUserFavouriteUpdateRequest>, IAppUserFavouriteService
    {

        public AppUserFavouriteService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<AppUserFavourite> AddFilter(IQueryable<AppUserFavourite> query, AppUserFavouriteSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.AppUserId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.AppUserId == search.AppUserId);
            }

            if (search?.TouristFacilityId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.TouristFacilityId == search.TouristFacilityId);
            }


            return filteredQuery;
        }

        public override IQueryable<AppUserFavourite> AddInclude(IQueryable<AppUserFavourite> query, AppUserFavouriteSearchObject search = null)
        {
            if(search?.IncludeAppUser == true)
            {
                query = query.Include("AppUser");
            }

            if (search?.IncludeTouristFacility == true)
            {
                query = query.Include("TouristFacilit");
            }

           
            return query;
        }

    }
}
