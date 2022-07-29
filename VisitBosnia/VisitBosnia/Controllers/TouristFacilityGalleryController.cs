using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class TouristFacilityGalleryController : BaseCRUDController<Model.TouristFacilityGallery, TouristFacilityGallerySearchObject, TouristFacilityGalleryInsertRequest, TouristFacilityGalleryUpdateRequest>
    {
        public TouristFacilityGalleryController(ITouristFacilityGalleryService service) : base(service)
        {
            
        }

      
    }
}
