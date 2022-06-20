using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class TouristFacilityGallery
    {
        public int Id { get; set; }
        public string? ImageType { get; set; }
        public bool? Thumbnail { get; set; }
        public byte[] Image { get; set; } = null!;
        public int TouristFacilityId { get; set; }

        public virtual TouristFacility TouristFacility { get; set; } = null!;
    }
}
