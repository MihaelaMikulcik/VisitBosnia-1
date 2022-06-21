using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class City
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string County { get; set; } = null!;
        public string ZipCode { get; set; } = null!;

        //public virtual ICollection<Agency> Agencies { get; set; }
        //public virtual ICollection<Forum> Forums { get; set; }
        //public virtual ICollection<TouristFacility> TouristFacilities { get; set; }
    }
}
