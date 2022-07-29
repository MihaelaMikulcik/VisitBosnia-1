using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class AgencyMemberController : BaseCRUDController<Model.AgencyMember, AgencyMemberSearchObject, AgencyMemberInsertRequest, AgencyMemberUpdateRequest>
    {
        public AgencyMemberController(IAgencyMemberService service) : base(service)
        {
            
        }

        
    }
}
