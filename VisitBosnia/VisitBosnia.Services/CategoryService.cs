using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class CategoryService : BaseCRUDService<Model.Category, Database.Category, CategorySearchObject, CategoryInsertRequest, CategoryUpdateRequest>, ICategoryService
    {

        public CategoryService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

     

    }
}
