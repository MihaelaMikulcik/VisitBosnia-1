using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class Transaction
    {
        public int Id { get; set; }
        public int EventOrderId { get; set; }
        public DateTime Date { get; set; }
        public string Status { get; set; } = null!;

        public virtual EventOrder EventOrder { get; set; } = null!;
    }
}
