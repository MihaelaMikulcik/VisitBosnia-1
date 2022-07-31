using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class TouristFacility
    {

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public int CityId { get; set; }
        public int CategoryId { get; set; }

        public virtual Category Category { get; set; } = null!;
        public virtual City City { get; set; } = null!;

        //public virtual Attraction Attraction { get; set; } = null!;
        //public virtual Event Event { get; set; } = null!;

        //public virtual ICollection<AppUserFavourite> AppUserFavourites { get; set; }
        //public virtual ICollection<Review> Reviews { get; set; }
        //public virtual ICollection<TouristFacilityGallery> TouristFacilityGalleries { get; set; }

        //public string? CategoryName => (Category != null ? Category.Name : "");
        //public string? CityName => (City != null ? City.Name : "");

        //public virtual City City { get; set; } = null!;
        //public virtual Category Category { get; set; } = null!;
    }
}
