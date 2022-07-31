using AutoMapper;
using Microsoft.EntityFrameworkCore;
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
    public class AttractionService : BaseCRUDService<Model.Attraction, Database.Attraction, AttractionSearchObject, AttractionInsertRequest, AttractionUpdateRequest>, IAttractionService
    {

        public AttractionService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<Attraction> AddInclude(IQueryable<Attraction> query, AttractionSearchObject search = null)
        {
            if (search?.IncludeIdNavigation == true)
            {
                query = query.Include("IdNavigation");
                query = query.Include("IdNavigation.City");
                query = query.Include("IdNavigation.Category");

            }

            return query;

        }


    }
}
