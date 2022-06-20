using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class Transaction
    {
        public int Id { get; set; }
        public int EventOrderId { get; set; }
        public DateTime Date { get; set; }
        public string Status { get; set; } = null!;

        public virtual EventOrder EventOrder { get; set; } = null!;
    }
}
