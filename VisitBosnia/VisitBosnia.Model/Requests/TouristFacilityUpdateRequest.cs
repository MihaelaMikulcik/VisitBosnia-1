using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class TouristFacilityUpdatetRequest
    {
        public string? Name { get; set; } = null!;
        public string? Description { get; set; }
        public int? CityId { get; set; }
        public int? CategoryId { get; set; }
    }
}
