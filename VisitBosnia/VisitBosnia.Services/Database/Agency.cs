using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class Agency
    {
        public Agency()
        {
            AgencyMembers = new HashSet<AgencyMember>();
            Events = new HashSet<Event>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Phone { get; set; } = null!;
        public string? ResponsiblePerson { get; set; }
        public string Address { get; set; } = null!;
        public int CityId { get; set; }

        public virtual City City { get; set; } = null!;
        public virtual ICollection<AgencyMember> AgencyMembers { get; set; }
        public virtual ICollection<Event> Events { get; set; }
    }
}
