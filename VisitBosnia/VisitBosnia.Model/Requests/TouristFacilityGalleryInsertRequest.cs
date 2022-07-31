﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class TouristFacilityGalleryInsertRequest
    {

        public string? ImageType { get; set; }
        public bool Thumbnail { get; set; }
        public byte[] Image { get; set; } 
        public int TouristFacilityId { get; set; }

    }
}
