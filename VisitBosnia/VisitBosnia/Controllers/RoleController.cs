using Microsoft.AspNetCore.Authorization;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    //[AllowAnonymous]
    public class RoleController : BaseReadController<Model.Role, object>
    {
        public RoleController(IReadService<Model.Role, object> service):base(service)
        {

        }
    }
}
