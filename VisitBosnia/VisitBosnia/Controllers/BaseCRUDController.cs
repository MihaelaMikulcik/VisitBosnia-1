using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseReadController<T, TSearch> where T : class where TSearch : class where TInsert : class where TUpdate : class
    {
        protected readonly ICRUDService<T, TSearch, TInsert, TUpdate> crudService;
        public BaseCRUDController(ICRUDService<T, TSearch, TInsert, TUpdate> service) : base(service)
        {
            crudService = service;
        }

        [HttpPost]
        public async virtual Task<T> Insert([FromBody] TInsert request)
        {
            return await crudService.Insert(request);
        }

        [HttpPut("{id}")]
        public async virtual Task<T> Update(int id, [FromBody] TUpdate request)
        {
           return await crudService.Update(id, request);
        }

        [Route("delete/{id}")]
        [HttpDelete]
        public async virtual Task<T> Delete(int id)
        {
            return await crudService.Delete(id);
        }
    }
}
