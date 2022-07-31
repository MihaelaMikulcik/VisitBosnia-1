using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class Event 
    {
        public int Id { get; set; }
        public int AgencyId { get; set; }
        public DateTime Date { get; set; }
        public int FromTime { get; set; }
        public int ToTime { get; set; }
        public string PlaceOfDeparture { get; set; } = null!;
        public decimal PricePerPerson { get; set; }
        public int MaxNumberOfParticipants { get; set; }
        public int AgencyMemberId { get; set; }

        public virtual Agency Agency { get; set; } = null!;
        public virtual AgencyMember AgencyMember { get; set; } = null!;
        public virtual TouristFacility IdNavigation { get; set; } = null!;

        //public string? CityName { get; set; } => (IdNavigation != null ? IdNavigation.City.Name : "");
        //public string? CategoryName { get; set; } => (IdNavigation != null ? IdNavigation.Category.Name : "");
    }
}
