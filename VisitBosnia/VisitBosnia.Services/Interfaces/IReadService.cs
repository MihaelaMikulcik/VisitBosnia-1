using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Services.Interfaces
{
    public interface IReadService<T, TSearch> where T : class where TSearch : class
    {
        public Task<List<T>> Get(TSearch search = null);
        public Task<T> GetById(int id);
    }
}
