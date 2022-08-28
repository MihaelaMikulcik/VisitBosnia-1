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
        private readonly IPostReplyService _postReplyService;
        public PostService(VisitBosniaContext context, IMapper mapper, IPostReplyService postReplySerice):base(context, mapper)
        {
            this._postReplyService = postReplySerice;
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

        public async override Task<Model.Post> Delete(int id)
        {
            //var entity = Context.Set<Services.Database.PostReply>().AsQueryable();
            //var postReply = entity.Where(x => x.PostId == id);
            var search = new PostReplySearchObject{PostId = id };
            var postReply = await _postReplyService.Get(search);
            if(postReply != null)
            {
                foreach(var reply in postReply)
                {
                    await _postReplyService.Delete(reply.Id);
                }
            }
            return await base.Delete(id);
        }

        public int? GetNumberOfReplies(int postId)
        {
            var entity = Context.Set<Services.Database.Post>().AsQueryable();
            entity = entity.Include("PostReplies");
            var post = entity.Where(x => x.Id == postId).FirstOrDefault();
            if (post != null)
            {
                return post.PostReplies.Count();
            }
            return null;
        }

        public override async Task<IEnumerable<Model.Post>> Get(PostSearchObject search = null)
        {
            var entity = Context.Set<Post>().AsQueryable();

            entity = AddFilter(entity, search);
            entity = AddInclude(entity, search);

            var list = await entity.ToListAsync();
            return Mapper.Map<List<Model.Post>>(list.OrderByDescending(x => x.CreatedTime).ToList());
        }
    }
}
