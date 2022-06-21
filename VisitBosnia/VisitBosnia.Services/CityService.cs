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
    public class CityService : BaseCRUDService<Model.City, Database.City, Model.CitySearchObject, Model.CityInsertRequest, Model.CityUpdateRequest>, ICityService
    {

        public CityService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        
    }
}
