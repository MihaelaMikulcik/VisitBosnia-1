using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.SearchObjects
{
    public class EventOrderSearchObject
    {
        public int? EventId { get; set; }
        //public int? AgencyId { get; set; }
        public int? AgencyMemberId { get; set; }
        public bool? IncludeAppUser { get; set; }




    }
}
