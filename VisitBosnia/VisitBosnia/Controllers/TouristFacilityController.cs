using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class TouristFacilityController : BaseCRUDController<Model.TouristFacility, TouristFacilitySearchObject, TouristFacilityInsertRequest, TouristFacilityUpdatetRequest>
    {
        public TouristFacilityController(ITouristFacilityService service) : base(service)
        {
            
        }

      
    }
}
