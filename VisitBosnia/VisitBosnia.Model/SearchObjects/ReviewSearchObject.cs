using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.SearchObjects
{
    public class ReviewSearchObject
    {
        public string? SearchText { get; set; }
        //public int? Rating { get; set; }
        public int? AgencyId { get; set; }
        public bool? IncludeTouristFacility { get; set; }
        public bool? IncludeAppUser { get; set; }
        public int? Rating { get; set; }

        public int? FacilityId { get; set; }

    }
}
