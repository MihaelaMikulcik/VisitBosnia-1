using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class TouristFacilitySearchObject 
    {
        public string? SearchText { get; set; }
        public bool IncludeCity { get; set; }
        public bool IncludeCategory { get; set; }
        public int? Id { get; set; }
    }
}
