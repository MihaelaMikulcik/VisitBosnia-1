using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class PostController:BaseCRUDController<Post, PostSearchObject, PostInsertRequest, object>
    {
        public PostController(IPostService service):base(service)
        {

        }
    }
}
