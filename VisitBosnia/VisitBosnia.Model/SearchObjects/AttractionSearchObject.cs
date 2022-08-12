using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AttractionSearchObject 
    {
        public string? SearchText { get; set; }
        public bool IncludeIdNavigation { get; set; }
        public int? CityId { get; set; }
        public int? CategoryId { get; set; }
    }
}
