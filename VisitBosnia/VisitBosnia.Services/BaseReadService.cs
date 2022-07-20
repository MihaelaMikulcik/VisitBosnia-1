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

        //public virtual async Task<List<T>> Get(TSearch search = null)
        //{
        //    var list = await Context.Set<TDb>().ToListAsync();
        //    return Mapper.Map<List<T>>(list);
        //}

        public virtual async Task<IEnumerable<T>> Get(TSearch search = null)
        {
            var entity = Context.Set<TDb>().AsQueryable();

            entity = AddFilter(entity, search);

            var list = await entity.ToListAsync();
            return Mapper.Map<List<T>>(list);
        }

        public virtual async Task<T> GetById(int id)
        {
            var set = Context.Set<TDb>();
            var entity = await set.FindAsync(id);
            return Mapper.Map<T>(entity);
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch search = null)
        {
            return query;
        }
    }
}
