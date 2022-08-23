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
    public class PostReplyService:BaseCRUDService<Model.PostReply, Database.PostReply, PostReplySearchObject, PostReplyInsertRequest, object>, IPostReplyService
    {
        public PostReplyService(VisitBosniaContext context, IMapper mapper):base(context, mapper)
        {

        }

        public override IQueryable<PostReply> AddFilter(IQueryable<PostReply> query, PostReplySearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (search.PostId != null)
            {
                filteredQuery = filteredQuery.Where(x=>x.PostId == search.PostId);
            }
            if (search.AppUserId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.AppUserId == search.AppUserId);
            }
            return filteredQuery;
        }

        public override IQueryable<PostReply> AddInclude(IQueryable<PostReply> query, PostReplySearchObject search = null)
        {
            if (search?.IncludeAppUser == true)
            {
                query = query.Include("AppUser");
            }

            return query;
        }

        public override async Task<IEnumerable<Model.PostReply>> Get(PostReplySearchObject search = null)
        {
            var entity = Context.Set<PostReply>().AsQueryable();

            entity = AddFilter(entity, search);
            entity = AddInclude(entity, search);

            var list = await entity.ToListAsync();
            return Mapper.Map<List<Model.PostReply>>(list.OrderBy(x => x.CreatedTime).ToList());
        }
    }
}
