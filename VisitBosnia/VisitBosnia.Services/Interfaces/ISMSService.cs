using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model.ViewModels;

namespace VisitBosnia.Services.Interfaces
{
    public interface ISMSService
    {
        public int SendSMS(SmsMessage message);
    }
}
