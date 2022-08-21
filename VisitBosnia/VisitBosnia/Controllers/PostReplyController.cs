using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class PostReplyController:BaseCRUDController<PostReply, PostReplySearchObject, PostReplyInsertRequest, object>
    {
        public PostReplyController(IPostReplyService service):base(service)
        {

        }
    }
}
