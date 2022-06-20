using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class AppUserRole
    {
        public int Id { get; set; }
        public int AppUserId { get; set; }
        public int RoleId { get; set; }

        public virtual AppUser AppUser { get; set; } = null!;
        public virtual Role Role { get; set; } = null!;
    }
}
