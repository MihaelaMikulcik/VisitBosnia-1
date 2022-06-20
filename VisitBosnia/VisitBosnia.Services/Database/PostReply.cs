using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class PostReply
    {
        public int Id { get; set; }
        public int AppUserId { get; set; }
        public int PostId { get; set; }
        public DateTime CreatedTime { get; set; }
        public string Content { get; set; } = null!;

        public virtual AppUser AppUser { get; set; } = null!;
        public virtual Post Post { get; set; } = null!;
    }
}
