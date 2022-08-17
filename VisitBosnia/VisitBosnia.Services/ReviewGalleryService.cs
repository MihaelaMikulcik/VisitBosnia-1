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
    public class ReviewGalleryService : BaseCRUDService<Model.ReviewGallery, Database.ReviewGallery, ReviewGallerySearchObject, ReviewGalleryInsertRequest, ReviewGalleryUpdateRequest>, IReviewGalleryService
    {

        public ReviewGalleryService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<ReviewGallery> AddFilter(IQueryable<ReviewGallery> query, ReviewGallerySearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
        

            if (search?.ReviewId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.ReviewId == search.ReviewId);
            }
          

            return filteredQuery;
        }

      

    }
}
