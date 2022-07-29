using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class AgencyMemberUpdateRequest
    {
        public int? AppUserId { get; set; }
        public int? AgencyId { get; set; }
    }
}
