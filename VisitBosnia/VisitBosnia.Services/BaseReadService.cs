using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class BaseReadService<T, TDb, TSearch> : IReadService<T, TSearch> where T : class where TDb : class where TSearch : class
    {
        public VisitBosniaContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public BaseReadService(VisitBosniaContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }
        public async Task<List<T>> Get(TSearch search = null)
        {
            var entity = Context.Set<TDb>();
            var list = await entity.ToListAsync();
            return Mapper.Map<List<T>>(list);
        }

        public async Task<T> GetById(int id)
        {
            var set = Context.Set<TDb>();
            var entity = await set.FindAsync(id);
            return Mapper.Map<T>(entity);
        }
    }
}
