using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class TouristFacilityUpdateRequest
    {
        public string? Name { get; set; } = null!;
        public string? Description { get; set; } = null;
        public int? CityId { get; set; } = null;
        public int? CategoryId { get; set; } = null;
    }
}
