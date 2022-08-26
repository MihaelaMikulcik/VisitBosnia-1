using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AppUserInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string FirstName { get; set; } = null!;

        [Required(AllowEmptyStrings = false)]
        public string LastName { get; set; } = null!;

        [Required(AllowEmptyStrings = false)]
        [EmailAddress]
        public string Email { get; set; } = null!;


        //[RegularExpression(@"^\(?\d{3}\)?-? *\d{3}-? *-?\d{3,4}$")]
        public string? Phone { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string UserName { get; set; } = null!;

        [Required(AllowEmptyStrings = false)]
        public string Password { get; set; } = null!;

        [Required(AllowEmptyStrings = false)]
        public string PasswordConfirm { get; set; } = null!;

        public byte[]? Image { get; set; }

        //[Required(AllowEmptyStrings = false)]
        public DateTime? DateOfBirth { get; set; }

        public bool IsBlocked { get; set; }
        public bool TempPass { get; set; }

        //public List<int> Roles { get; set; } = new List<int>();
    }
}
