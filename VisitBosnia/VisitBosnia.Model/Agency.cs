using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class Agency 
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Phone { get; set; } = null!;
        public string? ResponsiblePerson { get; set; }
        public string Address { get; set; } = null!;
        public int CityId { get; set; }

        public virtual City City { get; set; } = null!;

    }
}
