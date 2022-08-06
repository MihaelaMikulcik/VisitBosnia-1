using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace VisitBosnia.Model
{
    public partial class Attraction
    {
        [ForeignKey("IdNavigation")]
        public int Id { get; set; }
        //public string? AddressMap { get; set; }
        public decimal GeoLong { get; set; } 
        public decimal GeoLat { get; set; } 

        public virtual TouristFacility IdNavigation { get; set; } = null!;
    }
}
