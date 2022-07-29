using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class EventSearchObject 
    {
        public string? SearchText { get; set; }
        public bool IncludeCity { get; set; }
        public bool IncludeCategory { get; set; }
        public bool IncludeAgencyMember { get; set; }
        public bool IncludeAgency { get; set; }
    }
}
