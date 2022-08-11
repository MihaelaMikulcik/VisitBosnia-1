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
    public class AppUserRoleService : BaseCRUDService<Model.AppUserRole, Database.AppUserRole, AppUserRoleSearchObject, AppUserRoleInsertRequest, AppUserRoleUpdatetRequest>, IAppUserRoleService
    {

        public AppUserRoleService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<AppUserRole> AddFilter(IQueryable<AppUserRole> query, AppUserRoleSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (search.AppUserId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.AppUserId == search.AppUserId);
            }

            //if (!string.IsNullOrEmpty(search?.SearchText))
            //{
            //    filteredQuery = filteredQuery.Where(x => x.Name.ToLower().StartsWith(search.SearchText.ToLower()) || x.County.ToLower().StartsWith(search.SearchText.ToLower()) || x.ZipCode.ToLower().StartsWith(search.SearchText.ToLower()));
            //}



            return filteredQuery;
        }

    }
}
