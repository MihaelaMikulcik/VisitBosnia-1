using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class ForumInsertRequest
    {
        public string Title { get; set; } = null!;
        //public string? Description { get; set; }
        public int CityId { get; set; }
        public DateTime CreatedTime { get; set; }
       
    }
}
