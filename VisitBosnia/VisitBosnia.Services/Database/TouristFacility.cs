using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class TouristFacility
    {
        public TouristFacility()
        {
            AppUserFavourites = new HashSet<AppUserFavourite>();
            Reviews = new HashSet<Review>();
            TouristFacilityGalleries = new HashSet<TouristFacilityGallery>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public int CityId { get; set; }
        public int CategoryId { get; set; }

        public virtual Category Category { get; set; } = null!;
        public virtual City City { get; set; } = null!;
        public virtual Attraction Attraction { get; set; } = null!;
        public virtual Event Event { get; set; } = null!;
        public virtual ICollection<AppUserFavourite> AppUserFavourites { get; set; }
        public virtual ICollection<Review> Reviews { get; set; }
        public virtual ICollection<TouristFacilityGallery> TouristFacilityGalleries { get; set; }
    }
}
