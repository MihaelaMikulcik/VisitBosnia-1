using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Model.Requests
{
    public class CategoryInsertRequest
    {

        public string Name { get; set; } = null!;
        public string? Description { get; set; }
    }
}
