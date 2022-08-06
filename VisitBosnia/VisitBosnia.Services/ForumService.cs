using AutoMapper;
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
    public class ForumService : BaseCRUDService<Model.Forum, Database.Forum, ForumSearchObject, ForumInsertRequest, object>, IForumService
    {
        public ForumService(VisitBosniaContext context, IMapper mapper):base(context, mapper)
        {

                
        }
        public override IQueryable<Forum> AddFilter(IQueryable<Forum> query, ForumSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (search?.CityId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.CityId == search.CityId);
            }
            return filteredQuery;
        }
    }
}
