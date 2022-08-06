using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AttractionUpdateRequest
    {
        public int CityId { get; set; }
        public int CategoryId { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }

        public decimal GeoLong { get; set; }
        public decimal GeoLat { get; set; }

    }
}
