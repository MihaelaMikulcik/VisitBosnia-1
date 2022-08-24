using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class AgencyController : BaseCRUDController<Model.Agency, AgencySearchObject, AgencyInsertRequest, AgencyUpdateRequest>
    {
        public AgencyController(IAgencyService service) : base(service)
        {
            
        }

        [AllowAnonymous]
        public override Task<IEnumerable<Agency>> Get([FromQuery] AgencySearchObject search)
        {
            return base.Get(search);
        }
    }
}
