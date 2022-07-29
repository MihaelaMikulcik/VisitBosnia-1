using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class CategoryController : BaseCRUDController<Model.Category, CategorySearchObject, CategoryInsertRequest, CategoryUpdateRequest>
    {
        public CategoryController(ICategoryService service) : base(service)
        {
            
        }

        
    }
}
