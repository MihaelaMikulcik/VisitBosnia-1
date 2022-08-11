using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class AppUserFavouriteController : BaseCRUDController<Model.AppUserFavourite, AppUserFavouriteSearchObject, AppUserFavouriteInsertRequest, AppUserFavouriteUpdateRequest>
    {
        public AppUserFavouriteController(IAppUserFavouriteService service) : base(service)
        {
            
        }

    }
}
