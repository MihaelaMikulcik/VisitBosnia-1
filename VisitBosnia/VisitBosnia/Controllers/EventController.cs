using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class EventController : BaseCRUDController<Model.Event, EventSearchObject, EventInsertRequest, EventUpdateRequest>
    {
        public EventController(IEventService service) : base(service)
        {
            
        }

      
    }
}
