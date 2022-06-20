using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class Attraction
    {
        public int Id { get; set; }
        public string? AddressMap { get; set; }

        public virtual TouristFacility IdNavigation { get; set; } = null!;
    }
}
