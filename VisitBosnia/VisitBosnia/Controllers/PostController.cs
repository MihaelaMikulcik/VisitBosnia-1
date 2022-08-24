using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class PostController:BaseCRUDController<Post, PostSearchObject, PostInsertRequest, object>
    {
        IPostService service;
        public PostController(IPostService service):base(service)
        {
            this.service = service;
        }

        [HttpGet("GetNumberOfReplies")]
        public int? GetNumberOfReplies(int postId)
        {
            return service.GetNumberOfReplies(postId);
        }

    }
}
