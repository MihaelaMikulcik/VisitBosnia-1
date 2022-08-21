using AutoMapper;
using Microsoft.EntityFrameworkCore;
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
    public class PostService:BaseCRUDService<Model.Post, Database.Post, PostSearchObject, PostInsertRequest, object>, IPostService
    {
        public PostService(VisitBosniaContext context, IMapper mapper):base(context, mapper)
        {

        }

        public override IQueryable<Post> AddFilter(IQueryable<Post> query, PostSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (search.ForumId != null)
            {
                filteredQuery = filteredQuery.Where(x=>x.ForumId == search.ForumId);
            }
            if (!string.IsNullOrEmpty(search.Title))
            {
                filteredQuery = filteredQuery.Where(x=>x.Title.ToLower().Contains(search.Title.ToLower()));
            }
            return filteredQuery;
        }

        public override IQueryable<Post> AddInclude(IQueryable<Post> query, PostSearchObject search = null)
        {
            if (search?.IncludeAppUser == true)
            {
                query = query.Include("AppUser");
            }

            return query;
        }
    }
}
