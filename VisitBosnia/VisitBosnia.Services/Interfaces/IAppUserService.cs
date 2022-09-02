using Microsoft.ML;
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
        Task<Model.AppUser> ChangePassword(AppUserChangePasswordRequest request);
        Task<List<Model.Attraction>> RecommendAttracions(int appUserId, int? categoryId);
        Task<List<Model.Event>> RecommendEvents(int appUserId, int? categoryId);
        Task<bool> UsernameExists(string username);
        Task<bool> EmailExists(string email);

        //ITransformer TrainData(bool isAttraction, bool retrainData);
        //Task<bool> UsernameExists(string username);
    }
}
