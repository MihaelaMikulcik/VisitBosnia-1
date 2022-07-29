using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AgencyInsertRequest
    {

        public string Name { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Phone { get; set; } = null!;
        public string? ResponsiblePerson { get; set; }
        public string Address { get; set; } = null!;
        public int CityId { get; set; }


    }
}
