using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;

namespace VisitBosnia.Services.Interfaces
{
    public interface IAppUserService : ICRUDService<AppUser, AppUserSearchObject, AppUserInsertRequest, AppUserUpdateRequest>
    {
        Task<Model.AppUser> Login(string username, string password);
        Task<Model.AppUser> Register(AppUserInsertRequest request);
        //Task<bool> UsernameExists(string username);
    }
}
