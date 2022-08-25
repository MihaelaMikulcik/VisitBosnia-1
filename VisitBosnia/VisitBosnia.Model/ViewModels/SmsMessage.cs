using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.ViewModels
{
    public class SmsMessage
    {
        public string To { get; set; }
        public string From { get; set; }
        public string Message { get; set; }
    }
}
