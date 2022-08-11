using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AppUserFavouriteUpdateRequest
    {

        public int? AppUserId { get; set; }
        public int? TouristFacilityId { get; set; }
    }
}
