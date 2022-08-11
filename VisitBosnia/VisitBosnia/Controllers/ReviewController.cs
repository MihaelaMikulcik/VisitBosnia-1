using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class ReviewController:BaseCRUDController<Review, ReviewSearchObject, ReviewInsertRequest, object>
    {
        public ReviewController(IReviewService service):base(service)
        {

        }
    }
}
