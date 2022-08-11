using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AppUserFavouriteSearchObject 
    {
        public bool IncludeAppUser { get; set; }
        public bool IncludeTouristFacility { get; set; }
        public int? AppUserId { get; set; }
        public int? TouristFacilityId { get; set; }
    }
}
