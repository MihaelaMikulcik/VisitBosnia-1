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
    public class TouristFacilityService : BaseCRUDService<Model.TouristFacility, Database.TouristFacility, TouristFacilitySearchObject, TouristFacilityInsertRequest, TouristFacilityUpdatetRequest>, ITouristFacilityService
    {

        public TouristFacilityService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

     

    }
}
