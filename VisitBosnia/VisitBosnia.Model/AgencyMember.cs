using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class AgencyMember
    {
        public int Id { get; set; }
        public int AppUserId { get; set; }
        public int AgencyId { get; set; }

        public virtual Agency Agency { get; set; } = null!;
        public virtual AppUser AppUser { get; set; } = null!;

   
    }
}
