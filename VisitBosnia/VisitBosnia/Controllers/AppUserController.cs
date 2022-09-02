using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Model.ViewModels;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class AppUserController : BaseCRUDController<AppUser, AppUserSearchObject, AppUserInsertRequest, AppUserUpdateRequest>
    {
        private readonly IAppUserService service;



        public AppUserController(IAppUserService service) : base(service)
        {
            this.service = service;

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
            return await service.Register(request);
        }

        [HttpPost("ChangePassword")]
        public async Task<Model.AppUser> ChangePassword([FromBody] AppUserChangePasswordRequest request)
        {
            return await service.ChangePassword(request);
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

        [HttpGet("EmailExists")]
        public async Task<bool> EmailExists([FromQuery]string email)
        {
            return await service.EmailExists(email);
        }

        [HttpGet("UsernameExists")]
        public async Task<bool> UsernameExists([FromQuery]string username)
        {
            return await service.UsernameExists(username);
        }

     

    }
}
