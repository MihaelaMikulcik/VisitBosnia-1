using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class AppUserFavourite
    {
        public int Id { get; set; }
        public int AppUserId { get; set; }
        public int TouristFacilityId { get; set; }

        public virtual AppUser AppUser { get; set; } = null!;
        public virtual TouristFacility TouristFacility { get; set; } = null!;
    }
}
