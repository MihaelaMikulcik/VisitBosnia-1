using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class PostInsertRequest
    {
        public int AppUserId { get; set; }
        public int ForumId { get; set; }
        public DateTime CreatedTime { get; set; }
        public string Title { get; set; } = null!;
        public string Content { get; set; } = null!;

    }
}
