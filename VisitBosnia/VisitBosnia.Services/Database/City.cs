using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class City
    {
        public City()
        {
            Agencies = new HashSet<Agency>();
            Forums = new HashSet<Forum>();
            TouristFacilities = new HashSet<TouristFacility>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string County { get; set; } = null!;
        public string ZipCode { get; set; } = null!;
        public byte[]? Image { get; set; }

        public virtual ICollection<Agency> Agencies { get; set; }
        public virtual ICollection<Forum> Forums { get; set; }
        public virtual ICollection<TouristFacility> TouristFacilities { get; set; }
    }
}
