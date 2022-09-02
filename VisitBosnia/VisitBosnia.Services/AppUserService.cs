using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using Microsoft.ML.Transforms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Filters;
using VisitBosnia.Helpers;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Services
{
    public class AppUserService
        : BaseCRUDService<Model.AppUser, AppUser, AppUserSearchObject, AppUserInsertRequest, AppUserUpdateRequest>, IAppUserService
    {


        private readonly IMemoryCache _memoryCache;
        public AppUserService(VisitBosniaContext context, IMapper mapper, IMemoryCache memoryCache)
            : base(context, mapper)
        {
            _memoryCache = memoryCache;
 
        }


        public async Task<Model.AppUser> Login(string username, string password)
        {
   
                var user = await Context.AppUsers.FirstOrDefaultAsync(x => x.UserName == username); 
                if (user == null)
                {
                    return null;
                 
                }
                var hash = HashHelper.GenerateHash(user.PasswordSalt, password);
                if (hash != user.PasswordHash)
                {
                    return null;
                    
                }
                return Mapper.Map<Model.AppUser>(user);
         
        }

    

        public async Task<bool> UsernameExists(string username) 
        {
            var userExists = await Context.AppUsers.FirstOrDefaultAsync(x => x.UserName == username);
            if (userExists != null)
            {
                return true;
            }
            return false;
        }

        public async Task<bool> EmailExists(string email)
        {
            var userExists = await Context.AppUsers.FirstOrDefaultAsync(x => x.Email == email);
            if (userExists != null)
            {
                return true;
            }
            return false;
        }



        public async Task<Model.AppUser> Register(AppUserInsertRequest request)
        {

           
            if (await UsernameExists(request.UserName))
            {
                throw new UserException("Username already exists!");

            }
            if (await EmailExists(request.Email))
            {
                throw new UserException("Email already exists!");

            }
            if (request.Password != request.PasswordConfirm)
            {
                throw new UserException("Password and confirmation do not match!");
            }

            var entity = Mapper.Map<Database.AppUser>(request);
            entity.PasswordSalt = HashHelper.GenerateSalt();
            entity.PasswordHash = HashHelper.GenerateHash(entity.PasswordSalt, request.Password);

            await Context.AppUsers.AddAsync(entity);
            await Context.SaveChangesAsync();

          

            return Mapper.Map<Model.AppUser>(entity);
        }

        public async Task<Model.AppUser> ChangePassword(AppUserChangePasswordRequest request)
        {
            AppUser? user = await Context.AppUsers.FirstOrDefaultAsync(x => x.UserName == request.Username);
            if (user != null)
            {
                var oldHash = HashHelper.GenerateHash(user.PasswordSalt, request.OldPassword);
                if (oldHash != user.PasswordHash)
                {
                    throw new UserException("Sorry, old password is not correct!");
                }
                if (request.NewPassword != request.NewPasswordConfirm)
                {
                    throw new UserException("New password and confirmation do not match!");
                }
                user.PasswordSalt = HashHelper.GenerateSalt();
                user.PasswordHash = HashHelper.GenerateHash(user.PasswordSalt, request.NewPassword);

                if (user.TempPass == true)
                {
                    user.TempPass = false;
                    user.IsBlocked = false;
                }

                Context.AppUsers.Update(user);
                Context.SaveChanges();
                return Mapper.Map<Model.AppUser>(user);

            }
            throw new UserException("There is no user with this username!");


        }


        public async override Task<Model.AppUser> Update(int id, AppUserUpdateRequest request)
        {
            AppUser? user = await Context.AppUsers.FirstOrDefaultAsync(x => x.UserName == request.UserName);
            if (request.ChangedUsername && await UsernameExists(request.UserName!))
            {
                throw new UserException("Username already exists!");
            }
            if (request.ChangedEmail && await EmailExists(request.Email!))
            {
                throw new UserException("Email already exists!");
            }

            return await base.Update(id, request);
        }

        public override IQueryable<AppUser> AddFilter(IQueryable<AppUser> query, AppUserSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrEmpty(search?.SearchText))
            {
                filteredQuery = filteredQuery.Where(x => x.FirstName.ToLower().StartsWith(search.SearchText.ToLower()) || x.LastName.ToLower().StartsWith(search.SearchText.ToLower()) || x.Email.ToLower().StartsWith(search.SearchText.ToLower()) || x.UserName.ToLower().StartsWith(search.SearchText.ToLower()));
            }


           

            return filteredQuery;
        }

        class TouristFacilityRating
        {
            [KeyType(count: 400)]
            public uint AppUserId { get; set; }
            [KeyType(count: 400)]
            public uint FacilityId { get; set; }
            public float Rating { get; set; }
        }

        class TouristFacilityRatingPrediction
        {
            public float Label { get; set; }
            public float Score { get; set; }
        }

        static object isLocked = new object();
        private static MLContext mlContext = null;
     
        public async Task<List<Model.Attraction>> RecommendAttracions(int appUserId, int? categoryId = null)
        {
                

            var model = TrainData(true);

            var attractions = await Context.Attractions
                .Include(x => x.IdNavigation)
     
                .Include(x => x.IdNavigation.Category)
                .ToListAsync();

           

            var predictionResult = new List<Tuple<Database.Attraction, float>>();

            foreach (var attraction in attractions)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<TouristFacilityRating, TouristFacilityRatingPrediction>(model);

                var prediction = predictionEngine.Predict(new TouristFacilityRating
                {
                    FacilityId = (uint)attraction.Id,
                    AppUserId = (uint)appUserId
                });

                predictionResult.Add(new Tuple<Database.Attraction, float>(attraction, prediction.Score));
              
            }

        



            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1).Take(8).ToList();

            if (categoryId != 0)
                finalResult = finalResult.Where(x => x.IdNavigation.CategoryId == categoryId).ToList();



            return Mapper.Map<List<Model.Attraction>>(finalResult);
        }

        public async Task<List<Model.Event>> RecommendEvents(int appUserId, int? categoryId = null)
        {
            var model = TrainData(false);

            var events = await Context.Events
                .Include(x => x.IdNavigation)    
                .Include(x => x.IdNavigation.Category)          
                .ToListAsync();

          

            var predictionResult = new List<Tuple<Database.Event, float>>();

            foreach (var x in events)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<TouristFacilityRating, TouristFacilityRatingPrediction>(model);

                var prediction = predictionEngine.Predict(new TouristFacilityRating
                {
                    FacilityId = (uint)x.Id,
                    AppUserId = (uint)appUserId
                });

                predictionResult.Add(new Tuple<Database.Event, float>(x, prediction.Score));
                
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1).Take(8).ToList();

            if (categoryId != 0)
                finalResult = finalResult.Where(x => x.IdNavigation.CategoryId == categoryId).ToList();

            return Mapper.Map<List<Model.Event>>(finalResult);
        }


        public ITransformer TrainData(bool isAttraction)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                   mlContext = new MLContext();
                List<Review> tempData;

                if (isAttraction)
                {
                    tempData = Context.Reviews.Where(x => x.TouristFacility.Attraction != null)
                    .ToList();
                }
                else
                {
                    tempData = Context.Reviews.Where(x => x.TouristFacility.Event != null)
                    .ToList();
                }

                var data = new List<TouristFacilityRating>();

                foreach (var review in tempData)
                {
                    data.Add(new TouristFacilityRating
                    {
                        AppUserId = (uint)review.AppUserId,
                        FacilityId = (uint)review.TouristFacilityId,
                        Rating = review.Rating
                    });
                }

                var trainingData = mlContext.Data.LoadFromEnumerable(data);

                var options = new MatrixFactorizationTrainer.Options
                {
                    MatrixColumnIndexColumnName = "AppUserId",
                    MatrixRowIndexColumnName = "FacilityId",
                    LabelColumnName = "Rating",
                    NumberOfIterations = 20,
                    ApproximationRank = 100
                };

                var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                ITransformer model;

              

                if (isAttraction)
                {
                    model = _memoryCache.Get<ITransformer>("attractionsModel");
                    if (model == null)
                    {
                        model = est.Fit(trainingData);
                        _memoryCache.Set("attractionsModel", model, TimeSpan.FromMinutes(15));
                    }
                }
                else
                {
                    model = _memoryCache.Get<ITransformer>("eventsModel");
                    if (model == null)
                    {
                        model = est.Fit(trainingData);
                        _memoryCache.Set("eventsModel", model, TimeSpan.FromMinutes(15));
                    }
                }

                return model;
              
            }
        }


       

    }



}

