using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Controllers
{
    public class ReviewGalleryController : BaseCRUDController<Model.ReviewGallery, ReviewGallerySearchObject, ReviewGalleryInsertRequest, ReviewGalleryUpdateRequest>
    {
        public ReviewGalleryController(IReviewGalleryService service) : base(service)
        {
            
        }

      
    }
}
