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
        public bool IncludeIdNavigation { get; set; }
        public bool IncludeAgencyMember { get; set; }
        public bool IncludeAgency { get; set; }
        public int? CategoryId { get; set; }
        public int? CityId { get; set; }
        public int? AgencyId { get; set; }
        public int? AgencyMemberId { get; set; }

    }
}
