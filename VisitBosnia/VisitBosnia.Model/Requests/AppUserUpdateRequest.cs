using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AppUserUpdateRequest
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        [RegularExpression(@"^\(?\d{3}\)?-? *\d{3}-? *-?\d{3,4}$")]
        public string? Phone { get; set; } = null;
        public string UserName { get; set; } = null!;
        public byte[]? Image { get; set; } = null;
        //public DateTime? DateOfBirth { get; set; } = null;
        public bool? TempPass { get; set; }

        public bool? IsBlocked { get; set; } = null;
    }
}
