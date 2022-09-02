using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model
{
    public class Forum
    {
        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public string? Description { get; set; }
        public int CityId { get; set; }
        public DateTime CreatedTime { get; set; }
        public virtual City City { get; set; } = null!;
        
    }
}
