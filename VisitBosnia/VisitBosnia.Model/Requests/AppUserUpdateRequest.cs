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
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        //[RegularExpression(@"^\(?\d{3}\)?-? *\d{3}-? *-?\d{3,4}$")]
        public string? Phone { get; set; }
        public string? UserName { get; set; }
        public string? Email { get; set; }
        public byte[]? Image { get; set; }
        public DateTime? DateOfBirth { get; set; } = null;


        public bool? TempPass { get; set; }
        public bool? IsBlocked { get; set; }
        public bool ChangedUsername { get; set; }
        public bool ChangedEmail { get; set; }

    }
}
