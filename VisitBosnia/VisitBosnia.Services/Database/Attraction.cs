using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace VisitBosnia.Services.Database
{
    public partial class Attraction 
    {
        [ForeignKey("IdNavigation")]
        public int Id { get; set; }
        public string? AddressMap { get; set; }
        public double GeoLong { get; set; }
        public double GeoLat { get; set; }

        public virtual TouristFacility IdNavigation { get; set; } = null!;
    }
}
