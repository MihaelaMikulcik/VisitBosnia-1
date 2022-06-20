using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class Forum
    {
        public Forum()
        {
            Posts = new HashSet<Post>();
        }

        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public string? Description { get; set; }
        public int CityId { get; set; }
        public DateTime CreatedTime { get; set; }

        public virtual City City { get; set; } = null!;
        public virtual ICollection<Post> Posts { get; set; }
    }
}
