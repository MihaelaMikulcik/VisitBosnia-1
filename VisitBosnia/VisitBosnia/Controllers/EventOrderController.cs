using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class EventOrderController:BaseCRUDController<Model.EventOrder, EventOrderSearchObject, EventOrderInsertRequest, object>
    {
        public EventOrderController(IEventOrderService service):base(service)
        {

        }
    }
}
