using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class TransactionInsertRequest
    {

        //public int? EventOrderId { get; set; }
        public int EventId { get; set; }
        public int AppUserId { get; set; }
        public string Description { get; set; } = null!;
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public DateTime? Date { get; set; }
        public string? Status { get; set; }
        public CreditCardData creditCard { get; set; } = null!;
        //public string ExpMonth { get; set; }
        //public string ExpYear { get; set; }
        //public string Number { get; set; }
        //public string Cvc { get; set; }
        public string? ChargeId { get; set; }



    }
}
