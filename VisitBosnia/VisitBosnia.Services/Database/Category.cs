using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class Category
    {
        public Category()
        {
            TouristFacilities = new HashSet<TouristFacility>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }

        public virtual ICollection<TouristFacility> TouristFacilities { get; set; }
    }
}
