﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class TouristFacilityGallerySearchObject
    {
        public string? SearchText { get; set; }
        public int? FacilityId { get; set; }
        public bool? isThumbnail { get; set; }

    }
}
