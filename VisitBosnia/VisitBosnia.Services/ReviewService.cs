using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class ReviewService:BaseCRUDService<Model.Review, Database.Review, ReviewSearchObject, ReviewInsertRequest, object>, IReviewService
    {
        //private readonly IAppUserService _appUserService;
        public ReviewService(VisitBosniaContext context, IMapper mapper, IAppUserService appUserService):base(context, mapper)
        {
            //_appUserService = appUserService;
        }


        public override IQueryable<Review> AddFilter(IQueryable<Review> query, ReviewSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (search.AgencyId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.TouristFacility.Event.AgencyId == search.AgencyId);
            }

            if (!string.IsNullOrEmpty(search.SearchText))
            {
                filteredQuery = filteredQuery.Where(x => x.Text.ToLower().Contains(search.SearchText.ToLower()) || x.AppUser.FirstName.ToLower().StartsWith(search.SearchText.ToLower()) || x.AppUser.LastName.ToLower().StartsWith(search.SearchText.ToLower()) || x.TouristFacility.Name.ToLower().StartsWith(search.SearchText.ToLower()));
            }

            if (search.FacilityId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.TouristFacilityId == search.FacilityId);
            }

            if (search.Rating != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Rating == search.Rating);
            }

            return filteredQuery;
        }

        public override IQueryable<Review> AddInclude(IQueryable<Review> query, ReviewSearchObject search = null)
        {
            if ( search.IncludeAppUser == true)
            {
                query = query.Include("AppUser");
            }

            if (search.IncludeTouristFacility ==true && search.IncludeAppUser == true)
            {
                query = query.Include("TouristFacility");
                query = query.Include("AppUser");
            }
            return query;
        }

        //public override async Task<Model.Review> Insert(ReviewInsertRequest request)
        //{
        //    //var result = await base.Insert(request);
        //    Database.Review review = Mapper.Map<Database.Review>(request);
        //    await Context.Reviews.AddAsync(review);
        //    await Context.SaveChangesAsync();
        //    var isAttraction = await Context.Attractions.Where(x => x.IdNavigation.Id == request.TouristFacilityId).FirstOrDefaultAsync();
        //    if (isAttraction != null)
        //        _appUserService.TrainData(true, true);
        //    else
        //        _appUserService.TrainData(false, true);
        //    return Mapper.Map<Model.Review>(review);
        //    //return result;
        //}

    }
}
