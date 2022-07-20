using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
   
    public class CityController : BaseCRUDController<Model.City, CitySearchObject, CityInsertRequest, CityUpdateRequest>
    {
        public CityController(ICityService service) : base(service)
        {

        }

        //[HttpGet]
        //public string GetName()
        //{
        //    return "Ime test";
        //}

        [HttpGet("GetName2")]
        public async Task<IActionResult> GetName2()
        {
            var result = await base.GetById(1);
            return Ok(result.Name);
        }
    }
}
