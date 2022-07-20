using Microsoft.AspNetCore.Authorization;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    [AllowAnonymous]
    public class CityController : BaseCRUDController<Model.City, CitySearchObject, CityInsertRequest, CityUpdateRequest>
    {
        public CityController(ICityService service):base(service)
        {

        }
    }
}
