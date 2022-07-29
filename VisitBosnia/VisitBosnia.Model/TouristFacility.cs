using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class TouristFacility
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public int CityId { get; set; }
        public int CategoryId { get; set; }

        public string? CategoryName => (Category != null ? Category.Name : "");
        public string? CityName => (City != null ? City.Name : "");

        public virtual City City { get; set; } = null!;
        public virtual Category Category { get; set; } = null!;
    }
}
