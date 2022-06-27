using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Helpers;
using VisitBosnia.Model.Requests;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class AppUserService
        : BaseCRUDService<Model.AppUser, AppUser, AppUserSearchObject, AppUserInsertRequest, AppUserUpdateRequest>, IAppUserService
    {
        public AppUserService(VisitBosniaContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
        

        public async Task<Model.AppUser> Login(string username, string password)
        {
            var user = await Context.AppUsers.FirstOrDefaultAsync(x => x.UserName == username); //dodati role
            if(user == null)
            {
                throw new Exception("Wrong username or password!");
            }
            var hash = HashHelper.GenerateHash(user.PasswordSalt, password);
            if(hash != user.PasswordHash)
            {
                throw new Exception("Wron username or password!");
            }
            return Mapper.Map<Model.AppUser>(user);
        }

        public async override Task<Model.AppUser> Insert(AppUserInsertRequest request)
        {
            Database.AppUser user = Mapper.Map<Database.AppUser>(request);
            var userExists = Context.AppUsers.FirstOrDefault(x => x.UserName == request.UserName);
            if (userExists != null)
            {
                throw new Exception("Username already exists!");
            }
            if (request.Password != request.PasswordConfirm)
            {
                throw new Exception("Please confirm your password");
            }
            user.PasswordSalt = HashHelper.GenerateSalt();
            user.PasswordHash = HashHelper.GenerateHash(user.PasswordSalt, request.Password);

            Context.AppUsers.Add(user);
            Context.SaveChanges();
            return Mapper.Map<Model.AppUser>(user);
        }


        public Model.AppUser Register(AppUserInsertRequest request)
        {
            Database.AppUser user = Mapper.Map<Database.AppUser>(request);
            var userExists = Context.AppUsers.FirstOrDefault(x => x.UserName == request.UserName);
            if (userExists != null)
            {
                throw new Exception("Username already exists!");
            }
            if (request.Password != request.PasswordConfirm)
            {
                throw new Exception("Please confirm your password");
            }
            user.PasswordSalt = HashHelper.GenerateSalt();
            user.PasswordHash = HashHelper.GenerateHash(user.PasswordSalt, request.Password);

            Context.AppUsers.Add(user);
            Context.SaveChanges();
            return Mapper.Map<Model.AppUser>(user);
        }

    }
}
