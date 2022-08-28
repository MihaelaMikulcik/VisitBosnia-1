using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;

namespace VisitBosnia.Services.Interfaces
{
    public interface ITransactionService:ICRUDService<Model.Transaction, TransactionSearchObject, TransactionInsertRequest, object>
    {
        Task<Model.Transaction?> ProcessTransaction(TransactionInsertRequest transaction);

    }


}
