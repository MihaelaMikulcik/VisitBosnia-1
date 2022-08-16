using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class EventOrderController:BaseCRUDController<Model.EventOrder, object, EventOrderInsertRequest, object>
    {
        public EventOrderController(IEventOrderService service):base(service)
        {

        }
    }
}
