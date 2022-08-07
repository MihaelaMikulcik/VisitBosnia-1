using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class Post
    {
        public int Id { get; set; }
        public int AppUserId { get; set; }
        public int ForumId { get; set; }
        public DateTime CreatedTime { get; set; }
        public string Title { get; set; } = null!;
        public string Content { get; set; } = null!;

        public virtual AppUser AppUser { get; set; } = null!;
        public virtual Forum Forum { get; set; } = null!;
    }
}
