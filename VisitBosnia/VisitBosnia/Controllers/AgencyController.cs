using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class AgencyController : BaseCRUDController<Model.Agency, AgencySearchObject, AgencyInsertRequest, AgencyUpdateRequest>
    {
        public AgencyController(IAgencyService service) : base(service)
        {
            
        }

        
    }
}
