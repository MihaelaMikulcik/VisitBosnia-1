using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseReadService<T, TDb, TSearch>, ICRUDService<T,
        TSearch, TInsert, TUpdate> where T : class where TDb : class where TSearch : class where TInsert : class where TUpdate : class
    {
        public BaseCRUDService(VisitBosniaContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public async virtual Task<T> Insert(TInsert request)
        {     
                var set = Context.Set<TDb>();
                TDb entity = Mapper.Map<TDb>(request);
                set.Add(entity);
            await Context.SaveChangesAsync();


                return Mapper.Map<T>(entity);       
        }

        public async virtual Task<T> Update(int id, TUpdate request)
        {
            var set = Context.Set<TDb>();
            var entity = set.Find(id);
            Mapper.Map(request, entity);
            try
            {
                await Context.SaveChangesAsync();
            }
            catch(Exception ex)
            {

            }
            return Mapper.Map<T>(entity);
        }

        public async virtual Task<T> Delete(int id)
        {
            var set = Context.Set<TDb>();
            var entity = set.Find(id);
            set.Remove(entity);
                   
           await Context.SaveChangesAsync();

            return Mapper.Map<T>(entity);
        }

    }
}
