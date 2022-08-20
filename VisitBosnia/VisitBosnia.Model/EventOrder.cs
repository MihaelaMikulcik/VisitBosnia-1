using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class EventOrder
    {
        public int Id { get; set; }
        public int EventId { get; set; }
        public int AppUserId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }

        public virtual AppUser AppUser { get; set; } = null!;
        public virtual Event Event { get; set; } = null!;
    }
}
