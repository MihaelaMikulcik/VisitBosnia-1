using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class SendEmailRequest
    {
        public string Email { get; set; }
        public string AgencyName { get; set; }
        public string TempPass { get; set; }
    }
}
