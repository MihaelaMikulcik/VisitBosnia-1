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

        public double GeoLong { get; set; }
        public double GeoLat { get; set; }
    }
}
