using System;
using System.Collections.Generic;

namespace VisitBosnia.Model
{
    public partial class Review
    {
        public Review()
        {
            ReviewGalleries = new HashSet<ReviewGallery>();
        }

        public int Id { get; set; }
        public int AppUserId { get; set; }
        public int TouristFacilityId { get; set; }
        public int Rating { get; set; }
        public string? Text { get; set; }

        public virtual AppUser AppUser { get; set; } = null!;
        public virtual TouristFacility TouristFacility { get; set; } = null!;
        public virtual ICollection<ReviewGallery> ReviewGalleries { get; set; }
    }
}
