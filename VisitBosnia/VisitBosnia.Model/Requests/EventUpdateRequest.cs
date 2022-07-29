using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class EventUpdateRequest
    {
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public int CityId { get; set; }
        public int CategoryId { get; set; }

        public int AgencyId { get; set; }
        public int AgencyMemberId { get; set; }
        public DateTime Date { get; set; }
        public int FromTime { get; set; }
        public int ToTime { get; set; }
        public string PlaceOfDeparture { get; set; } = null!;
        public decimal PricePerPerson { get; set; }
        public int MaxNumberOfParticipants { get; set; }
    }
}
