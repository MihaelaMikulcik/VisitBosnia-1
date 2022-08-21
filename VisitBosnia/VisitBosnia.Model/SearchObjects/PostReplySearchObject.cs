using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.SearchObjects
{
    public class PostReplySearchObject
    {
        public int? AppUserId { get; set; }
        public int? PostId { get; set; }
        public bool IncludeAppUser { get; set; }
    }
}
