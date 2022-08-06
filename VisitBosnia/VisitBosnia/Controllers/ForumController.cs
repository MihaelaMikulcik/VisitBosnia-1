using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class ForumController:BaseCRUDController<Forum, ForumSearchObject, ForumInsertRequest, object>
    {
        public ForumController(IForumService service):base(service)
        {
           
        }
    }
}
