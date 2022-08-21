using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AppUserRoleSearchObject 
    {
        public int? RoleId { get; set; }
        public int? AppUserId { get; set; }
        public bool IncludeRole { get; set; }
    }
}
