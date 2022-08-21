using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class PostReplyInsertRequest
    {
        public int AppUserId { get; set; }
        public int PostId { get; set; }
        public DateTime CreatedTime { get; set; }
        public string Content { get; set; } = null!;

    }
}
