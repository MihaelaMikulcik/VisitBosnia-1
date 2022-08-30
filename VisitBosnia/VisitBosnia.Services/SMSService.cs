using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model.ViewModels;
using VisitBosnia.Services.Interfaces;
using Vonage;
using Vonage.Request;

namespace VisitBosnia.Services
{
    public class SMSService:ISMSService
    {
        private string APIKey { get; }
        private string APISecret { get; }
        private readonly IConfiguration _configuration;
        public SMSService(IConfiguration configuration)
        {
            _configuration = configuration;
            APIKey = _configuration["SMSGatewayConfiguration:APIKey"];
            APISecret = _configuration["SMSGatewayConfiguration:APISecret"];
        }

        public int SendSMS(SmsMessage message)
        {
            try
            {
                var credentials = Credentials.FromApiKeyAndSecret(APIKey, APISecret);

                var VonageClient = new VonageClient(credentials);

                var response = VonageClient.SmsClient.SendAnSms(new Vonage.Messaging.SendSmsRequest()
                {
                    To = message.To,
                    From = message.From,
                    Text = message.Message
                });
                if (response.MessageCount.Length > 0)
                    return 200;
                else
                    return 400;

            }
            catch (Exception ex)
            {
                return 400;
            }
        }
    }
}
