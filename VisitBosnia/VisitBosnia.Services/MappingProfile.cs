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
            CreateMap<Database.City, Model.Requests.CityInsertRequest>().ReverseMap();
            CreateMap<Database.City, Model.Requests.CityUpdateRequest>().ReverseMap();

            CreateMap<Database.AppUser, Model.AppUser>().ReverseMap();
            CreateMap<Database.AppUser, Model.Requests.AppUserInsertRequest>().ReverseMap();
            CreateMap<Database.AppUser, Model.Requests.AppUserUpdateRequest>().ReverseMap();

            CreateMap<Database.Role, Model.Role>().ReverseMap();

            CreateMap<Database.Agency, Model.Agency>().ReverseMap();
            CreateMap<Database.Agency, Model.Requests.AgencyInsertRequest>().ReverseMap();
            CreateMap<Database.Agency, Model.Requests.AgencyUpdateRequest>().ReverseMap();

            CreateMap<Database.AgencyMember, Model.AgencyMember>().ReverseMap();
            CreateMap<Database.AgencyMember, Model.Requests.AgencyMemberInsertRequest>().ReverseMap();
            CreateMap<Database.AgencyMember, Model.Requests.AgencyMemberUpdateRequest>().ReverseMap();

            CreateMap<Database.Event, Model.Event>().ReverseMap();
            CreateMap<Database.Event, Model.Requests.EventInsertRequest>().ReverseMap();
            CreateMap<Database.Event, Model.Requests.EventUpdateRequest>().ReverseMap();

            CreateMap<Database.Category, Model.Category>().ReverseMap();
            CreateMap<Database.Category, Model.Requests.CategoryInsertRequest>().ReverseMap();
            CreateMap<Database.Category, Model.Requests.CategoryUpdateRequest>().ReverseMap();

            CreateMap<Database.Attraction, Model.Attraction>().ReverseMap();
            CreateMap<Database.Attraction, Model.Requests.AttractionInsertRequest>().ReverseMap();
            CreateMap<Database.Attraction, Model.Requests.AttractionUpdateRequest>().ReverseMap();

            CreateMap<Database.AppUserRole, Model.AppUserRole>().ReverseMap();
            CreateMap<Database.AppUserRole, Model.Requests.AppUserRoleInsertRequest>().ReverseMap();
            CreateMap<Database.AppUserRole, Model.Requests.AppUserRoleUpdatetRequest>().ReverseMap();

            CreateMap<Database.TouristFacility, Model.TouristFacility>().ReverseMap();
            CreateMap<Database.TouristFacility, Model.Requests.TouristFacilityInsertRequest>().ReverseMap();
            CreateMap<Database.TouristFacility, Model.Requests.TouristFacilityUpdateRequest>().ReverseMap();

            CreateMap<Database.TouristFacilityGallery, Model.TouristFacilityGallery>().ReverseMap();
            CreateMap<Database.TouristFacilityGallery, Model.Requests.TouristFacilityGalleryInsertRequest>().ReverseMap();
            CreateMap<Database.TouristFacilityGallery, Model.Requests.TouristFacilityGalleryUpdateRequest>().ReverseMap();
        }
    }
}
