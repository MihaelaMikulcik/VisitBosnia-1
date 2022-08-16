using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model.Requests;

namespace VisitBosnia.Services.Interfaces
{
    public interface ITransactionService:ICRUDService<Model.Transaction, object, TransactionInsertRequest, object>
    {
    }
}
