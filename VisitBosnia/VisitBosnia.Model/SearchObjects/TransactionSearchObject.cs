using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.SearchObjects
{
    public class TransactionSearchObject
    {
        public int? AppUserId { get; set; }
        public string? Status { get; set; }
        public bool? IncludeEventOrder { get; set; }


    }
}
