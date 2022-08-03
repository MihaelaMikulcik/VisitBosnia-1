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
    public class TouristFacilityGalleryService : BaseCRUDService<Model.TouristFacilityGallery, Database.TouristFacilityGallery, TouristFacilityGallerySearchObject, TouristFacilityGalleryInsertRequest, TouristFacilityGalleryUpdateRequest>, ITouristFacilityGalleryService
    {

        public TouristFacilityGalleryService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<TouristFacilityGallery> AddFilter(IQueryable<TouristFacilityGallery> query, TouristFacilityGallerySearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.FacilityId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.TouristFacilityId == search.FacilityId);
            }

            if (search?.isThumbnail != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Thumbnail == search.isThumbnail);
            }

            return filteredQuery;
        }



    }
}
