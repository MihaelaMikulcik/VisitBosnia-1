using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class AttractionController : BaseCRUDController<Model.Attraction, AttractionSearchObject, AttractionInsertRequest, AttractionUpdateRequest>
    {
        public AttractionController(IAttractionService service) : base(service)
        {
            
        }

        
    }
}
