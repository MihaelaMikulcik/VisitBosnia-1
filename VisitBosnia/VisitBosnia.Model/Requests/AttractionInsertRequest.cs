using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AttractionInsertRequest
    {
        public int Id { get; set; }
        public string? AddressMap { get; set; }

        public decimal GeoLong { get; set; }
        public decimal GeoLat { get; set; }
    }
}
