using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class RoleService : BaseReadService<Model.Role, Database.Role, object>
    {
        public RoleService(VisitBosniaContext context, IMapper mapper) : base(context, mapper)
        {

        }

    }
}
