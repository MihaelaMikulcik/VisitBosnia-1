using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class AppUserController : BaseCRUDController<AppUser, AppUserSearchObject, AppUserInsertRequest, AppUserUpdateRequest>
    {
        private readonly IAppUserService service;
        public AppUserController(IAppUserService service):base(service)
        {
            this.service = service;
        }

        [HttpGet]
        public override Task<List<AppUser>> Get([FromQuery] AppUserSearchObject search)
        {
            return base.Get(search);
        }

        [AllowAnonymous]
        [HttpGet("/Login")]
        public async Task<AppUser> Login([FromQuery]AppUserLoginRequest request)
        {
            return await service.Login(request.Username, request.Password); 
        }

        [AllowAnonymous]
        [HttpPost("/Insert")]
        public async override Task<Model.AppUser> Insert([FromBody] AppUserInsertRequest request)
        {
            return await service.Insert(request);
        }

        [AllowAnonymous]
        [HttpPost("Register")]
        public async Task<Model.AppUser> Register(/*[FromBody]*/AppUserInsertRequest request)
        {
            return await service.Insert(request);
        }

        //[AllowAnonymous]
        //[HttpPost("/Register")]
        //public Model.AppUser Register([FromBody]AppUserInsertRequest request)
        //{
        //    return service.Register(request);
        //}


    }
}
