using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class EventController : BaseCRUDController<Model.Event, EventSearchObject, EventInsertRequest, EventUpdateRequest>
    {
        IEventService service;
        public EventController(IEventService service) : base(service)
        {
            this.service = service;
        }

        [HttpGet("GetNumberOfParticipants")]
        public int GetNumberOfParticipants(int eventId)
        {
            return service.GetNumberOfParticipants(eventId);
        }


    }
}
