using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.SearchObjects
{
    public class ForumSearchObject
    {
        public string? SearchText { get; set; }
        public string? Name { get; set; }
        public string? County { get; set; }
        public string? ZipCode { get; set; }
        public int? CityId { get; set; }

    }
}
