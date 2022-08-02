using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class CityInsertRequest
    {
        public string Name { get; set; } = null!;
        public string County { get; set; } = null!;
        public string ZipCode { get; set; } = null!;

        public byte[]? Image { get; set; }

    }
}
