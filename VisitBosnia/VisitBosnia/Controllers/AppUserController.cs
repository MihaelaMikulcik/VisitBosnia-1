using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Twilio.Clients;
using Twilio.Rest.Api.V2010.Account;
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
        private readonly ITwilioRestClient _client;
        private readonly IConfiguration _config;

        public AppUserController(IAppUserService service, ITwilioRestClient client, IConfiguration config) : base(service)
        {
            this.service = service;
            _client = client;
            _config = config;
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

        //[AllowAnonymous]
        //[HttpPost("SendEmail")]
        //public void SendEmail([FromBody] SendEmailRequest request)
        //{
        //     service.SendEmail(request);
        //}


        [HttpPost("SendSms")]
        public int SendSms(SmsMessage model)
        {
            var message = MessageResource.Create(
                to: new Twilio.Types.PhoneNumber(model.To),
                from: new Twilio.Types.PhoneNumber(_config["Twilio:Number"]),
                body: model.Message,
                client: _client); // pass in the custom client

            return 200;
        }

    }
}
