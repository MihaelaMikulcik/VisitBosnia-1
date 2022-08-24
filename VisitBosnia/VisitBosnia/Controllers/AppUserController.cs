using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
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

        //[HttpGet]
        //public override Task<IEnumerable<AppUser>> Get([FromQuery] AppUserSearchObject search = null)
        //{
        //    return base.Get(search);
        //}

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
            return await service.Register(request);
        }

        [HttpGet("RecommendAttractions")]
        public async Task<List<Model.Attraction>> RecommendAttractions(int appUserId, int categoryId)
        {
            var attractions = await service.RecommendAttracions(appUserId, categoryId);
            return attractions;
        }

        [HttpGet("RecommendEvents")]
        public async Task<List<Model.Event>> RecommendEvents(int appUserId, int categoryId)
        {
            var events = await service.RecommendEvents(appUserId, categoryId);
            return events;
        }

        [HttpPost("/SendEmail")]
        public void SendEmail([FromBody] SendEmailRequest request)
        {
             service.SendEmail(request);
        }


    }
}
