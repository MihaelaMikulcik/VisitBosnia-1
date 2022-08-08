using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.SearchObjects
{
    public class ForumSearchObject
    {
        //public string? SearchText { get; set; }
        public string? Title { get; set; }
        public int? CityId { get; set; }
        public bool? IncludeCity { get; set; }

    }
}
