using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class Role
    {
        public Role()
        {
            AppUserRoles = new HashSet<AppUserRole>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }

        public virtual ICollection<AppUserRole> AppUserRoles { get; set; }
    }
}
