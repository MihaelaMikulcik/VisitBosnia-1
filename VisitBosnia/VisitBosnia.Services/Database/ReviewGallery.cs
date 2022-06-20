using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class ReviewGallery
    {
        public int Id { get; set; }
        public string? ImageType { get; set; }
        public byte[] Image { get; set; } = null!;
        public int ReviewId { get; set; }

        public virtual Review Review { get; set; } = null!;
    }
}
