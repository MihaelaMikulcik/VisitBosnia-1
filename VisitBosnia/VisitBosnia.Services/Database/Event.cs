using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class Event : TouristFacility
    {
        public Event()
        {
            EventOrders = new HashSet<EventOrder>();
        }

        public int AgencyId { get; set; }
        public int AgencyMemberId { get; set; }
        public DateTime Date { get; set; }
        public int FromTime { get; set; }
        public int ToTime { get; set; }
        public string PlaceOfDeparture { get; set; } = null!;
        public decimal PricePerPerson { get; set; }
        public int MaxNumberOfParticipants { get; set; }



        public virtual Agency Agency { get; set; } = null!;
        public virtual AgencyMember AgencyMember { get; set; } = null!;
        public virtual TouristFacility IdNavigation { get; set; } = null!;
        public virtual ICollection<EventOrder> EventOrders { get; set; }
    }
}
