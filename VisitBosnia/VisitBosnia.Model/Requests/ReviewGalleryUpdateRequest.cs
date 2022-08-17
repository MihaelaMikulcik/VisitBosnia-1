using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class ReviewGalleryUpdateRequest
    {
        public string? ImageType { get; set; }
        public byte[]? Image { get; set; } = null!;
        public int? ReviewId { get; set; }
    }
}
