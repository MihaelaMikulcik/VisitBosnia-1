﻿using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Filters;
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
                return null;
                //throw new MyException("Wrong username or password!");
            }
            var hash = HashHelper.GenerateHash(user.PasswordSalt, password);
            if(hash != user.PasswordHash)
            {
                return null;
                //throw new MyException("Wron username or password!");
            }
            return Mapper.Map<Model.AppUser>(user);
        }

        public async override Task<Model.AppUser> Insert(AppUserInsertRequest request)
        {
            var userExists = Context.AppUsers.FirstOrDefault(x => x.UserName == request.UserName);
            if (userExists != null)
            {
                throw new Exception("Username already exists!"); //napraviti odvojenu async funk
            }
            if (request.Password != request.PasswordConfirm)
            {
                throw new Exception("Please confirm your password");
            }
            Database.AppUser user = Mapper.Map<Database.AppUser>(request);
            user.PasswordSalt = HashHelper.GenerateSalt();
            user.PasswordHash = HashHelper.GenerateHash(user.PasswordSalt, request.Password);

            await Context.AppUsers.AddAsync(user);
            await Context.SaveChangesAsync();
            return Mapper.Map<Model.AppUser>(user);
        }

        public async Task<Model.AppUser> Register(AppUserInsertRequest request)
        {
            if (request.Password != request.PasswordConfirm)
            {
                throw new Exception("Password and confirmation do not match!");
            }

            var entity = Mapper.Map<Database.AppUser>(request);
            entity.PasswordSalt = HashHelper.GenerateSalt();
            entity.PasswordHash = HashHelper.GenerateHash(entity.PasswordSalt, request.Password);

            await Context.AppUsers.AddAsync(entity);
            await Context.SaveChangesAsync();

            //var role = await Context.Roles
            //    .Where(i => i.Name == "User")
            //    .SingleAsync();


            //var userRole = new Database.AppUserRole()
            //{
            //    AppUserId = entity.Id,
            //    RoleId = role.Id
            //};

            //await Context.AppUserRoles.AddAsync(userRole);
            //await Context.SaveChangesAsync();

            return Mapper.Map<Model.AppUser>(entity);
        }

        //public async Task<Model.AppUser> Register(AppUserInsertRequest request)
        //{
        //    Database.AppUser user = Mapper.Map<Database.AppUser>(request);
        //    var userExists = Context.AppUsers.FirstOrDefault(x => x.UserName == request.UserName);
        //    if (userExists != null)
        //    {
        //        throw new Exception("Username already exists!");
        //    }
        //    if (request.Password != request.PasswordConfirm)
        //    {
        //        throw new Exception("Please confirm your password");
        //    }
        //    user.PasswordSalt = HashHelper.GenerateSalt();
        //    user.PasswordHash = HashHelper.GenerateHash(user.PasswordSalt, request.Password);

        //    await Context.AppUsers.AddAsync(user);
        //    await Context.SaveChangesAsync();
        //    return Mapper.Map<Model.AppUser>(user);
        //}

    }
}
