using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class EventOrderInsertRequest
    {
        public int EventId { get; set; }
        public int AppUserId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
    }
}
