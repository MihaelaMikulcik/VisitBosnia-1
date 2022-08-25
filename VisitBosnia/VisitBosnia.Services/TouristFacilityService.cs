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
    public class TouristFacilityService : BaseCRUDService<Model.TouristFacility, Database.TouristFacility, TouristFacilitySearchObject, TouristFacilityInsertRequest, TouristFacilityUpdateRequest>, ITouristFacilityService
    {
        private readonly IReviewService reviewService;

        public TouristFacilityService(VisitBosniaContext context, IMapper mapper, IReviewService reviewService)
            : base(context, mapper)
        {
            this.reviewService = reviewService;
        }

        public override IQueryable<TouristFacility> AddInclude(IQueryable<TouristFacility> query, TouristFacilitySearchObject search = null)
        {

            if (search?.IncludeCity == true)
            {
                query = query.Include("City");
            }

            if (search?.IncludeCategory == true)
            {
                query = query.Include("Category");
            }

            return query;
        }

        public override IQueryable<TouristFacility> AddFilter(IQueryable<TouristFacility> query, TouristFacilitySearchObject search = null)
        {
            if (search?.Id != 0 && search?.Id != null)
            {
                query = query.Where(x=> x.Id == search.Id);
            }

            return query;
        }

        public override async Task<Model.TouristFacility> GetById(int id)
        {
            var entity = Context.Set<Services.Database.TouristFacility>().AsQueryable();

            entity = entity.Include("City");
            entity = entity.Include("Category");

            var model = entity.Where(x => x.Id == id).FirstOrDefault();

            return Mapper.Map<Model.TouristFacility>(model);
        }

        public async Task<double> GetRating(int Id)
        {
            var reviews = await reviewService.Get(new Model.SearchObjects.ReviewSearchObject { FacilityId = Id });
            double rating = 0;
            if(reviews.Count() > 0)
            {
                
                var one = reviews.Where(x => x.Rating == 1).ToList().Count;
                var two = reviews.Where(x => x.Rating == 2).ToList().Count; 
                var three = reviews.Where(x => x.Rating == 3).ToList().Count; 
                var four = reviews.Where(x => x.Rating == 4).ToList().Count; 
                var five = reviews.Where(x => x.Rating == 5).ToList().Count; 
                var total = one + two + three + four + five;

            if (total != 0)
            {
                rating = (one + two * 2 + three * 3 + four * 4 + five * 5) / total;
            }

            }
            return rating;
        }

    }
}
