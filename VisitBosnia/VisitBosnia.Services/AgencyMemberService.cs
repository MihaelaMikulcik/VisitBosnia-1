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
    public class AgencyMemberService : BaseCRUDService<Model.AgencyMember, Database.AgencyMember, AgencyMemberSearchObject, AgencyMemberInsertRequest, AgencyMemberUpdateRequest>, IAgencyMemberService
    {

        public AgencyMemberService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {

        }

        public override IQueryable<AgencyMember> AddFilter(IQueryable<AgencyMember> query, AgencyMemberSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.AgencyId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.AgencyId == search.AgencyId);
            }

            if (search?.AppUserId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.AppUserId == search.AppUserId);
            }

            return filteredQuery;
        }

    }
}
