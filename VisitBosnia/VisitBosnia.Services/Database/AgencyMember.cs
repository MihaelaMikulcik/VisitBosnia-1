using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class AgencyMember
    {
        public AgencyMember()
        {
            Events = new HashSet<Event>();
        }

        public int Id { get; set; }
        public int AppUserId { get; set; }
        public int AgencyId { get; set; }

        public virtual Agency Agency { get; set; } = null!;
        public virtual AppUser AppUser { get; set; } = null!;
        public virtual ICollection<Event> Events { get; set; }
    }
}
