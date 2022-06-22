using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class CityContoller : BaseCRUDController<Model.City, CitySearchObject, CityInsertRequest, CityUpdateRequest>
    {
        public CityContoller(ICityService service):base(service)
        {

        }
    }
}
