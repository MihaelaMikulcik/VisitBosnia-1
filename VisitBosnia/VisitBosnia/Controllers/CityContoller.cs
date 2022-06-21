using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class CityContoller : BaseCRUDController<Model.City, Model.CitySearchObject, Model.CityInsertRequest, Model.CityUpdateRequest>
    {
        public CityContoller(ICityService service):base(service)
        {

        }
    }
}
