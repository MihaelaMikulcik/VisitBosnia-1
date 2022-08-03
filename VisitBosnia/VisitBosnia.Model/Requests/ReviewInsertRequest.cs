using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class ReviewInsertRequest
    {

        public int AppUserId { get; set; }
        public int TouristFacilityId { get; set; }
        public int Rating { get; set; }
        public string? Text { get; set; }

    }
}
