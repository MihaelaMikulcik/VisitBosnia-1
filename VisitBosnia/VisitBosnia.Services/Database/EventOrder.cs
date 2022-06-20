using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class EventOrder
    {
        public EventOrder()
        {
            Transactions = new HashSet<Transaction>();
        }

        public int Id { get; set; }
        public int EventId { get; set; }
        public int AppUserId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }

        public virtual AppUser AppUser { get; set; } = null!;
        public virtual Event Event { get; set; } = null!;
        public virtual ICollection<Transaction> Transactions { get; set; }
    }
}
