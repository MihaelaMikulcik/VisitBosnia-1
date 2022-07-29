using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class AppUserRoleController : BaseCRUDController<Model.AppUserRole, AppUserRoleSearchObject, AppUserRoleInsertRequest, AppUserRoleUpdatetRequest>
    {
        public AppUserRoleController(IAppUserRoleService service) : base(service)
        {
            
        }

        
    }
}
