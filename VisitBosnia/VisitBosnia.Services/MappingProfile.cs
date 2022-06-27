using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VisitBosnia.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.City, Model.City>().ReverseMap();
            CreateMap<Database.AppUser, Model.AppUser>().ReverseMap();
            CreateMap<Database.AppUser, Model.Requests.AppUserInsertRequest>().ReverseMap();

        }
    }
}
