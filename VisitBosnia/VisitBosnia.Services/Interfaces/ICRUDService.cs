using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Services.Interfaces
{
    public interface ICRUDService<T, TSearch, TInsert, TUpdate> : IReadService<T, TSearch> where T : class where TSearch : class where TInsert : class where TUpdate : class
    {
        Task<T> Insert(TInsert request);
        Task<T> Update(int id, TUpdate request);
        Task<T> Delete(int id);
    }
}
