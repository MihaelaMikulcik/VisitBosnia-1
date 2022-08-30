using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.ViewModels;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class SMSController
    {
        ISMSService _service;
        public SMSController(ISMSService service)
        {
            _service = service;
        }

        [HttpPost("SendSMS")]
        public int SendSMS(SmsMessage message)
        {
            return _service.SendSMS(message);
        }

    }
}
