using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class Post
    {
        public Post()
        {
            PostReplies = new HashSet<PostReply>();
        }

        public int Id { get; set; }
        public int AppUserId { get; set; }
        public int ForumId { get; set; }
        public DateTime CreatedTime { get; set; }
        public string Title { get; set; } = null!;
        public string Content { get; set; } = null!;

        public virtual AppUser AppUser { get; set; } = null!;
        public virtual Forum Forum { get; set; } = null!;
        public virtual ICollection<PostReply> PostReplies { get; set; }
    }
}
