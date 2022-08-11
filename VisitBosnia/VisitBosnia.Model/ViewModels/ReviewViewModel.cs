using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.ViewModels
{
    public class ReviewViewModel
    {
        public string AppUserName { get; set; }
        public string TouristFacilityName { get; set; }
        public int Rating { get; set; }
        public string? Text { get; set; }

    }
}
