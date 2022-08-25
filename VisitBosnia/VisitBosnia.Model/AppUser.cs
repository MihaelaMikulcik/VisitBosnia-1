using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class AppUser
    {
        public int Id { get; set; }
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? Phone { get; set; }
        public string UserName { get; set; } = null!;
        public bool IsBlocked { get; set; }
        public byte[]? Image { get; set; }
        public bool TempPass { get; set; }

        //public DateTime? DateOfBirth { get; set; }

        //public virtual ICollection<AppUserRole> AppUserRoles { get; set; }

    }
}
