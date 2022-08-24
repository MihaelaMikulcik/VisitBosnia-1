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
        private readonly IEmailSender _emailSender;

        private readonly IMemoryCache _memoryCache;
        public AppUserService(VisitBosniaContext context, IMapper mapper, IMemoryCache memoryCache, IEmailSender emailSender)
            : base(context, mapper)
        {
            _memoryCache = memoryCache;
            _emailSender = emailSender;
        }


        public async Task<Model.AppUser> Login(string username, string password)
        {
            var user = await Context.AppUsers.FirstOrDefaultAsync(x => x.UserName == username); //dodati role
            if(user == null)
            {
                return null;
                //throw new UserException("Wrong username or password!", System.Net.HttpStatusCode.BadRequest);
            }
            var hash = HashHelper.GenerateHash(user.PasswordSalt, password);
            if(hash != user.PasswordHash)
            {
                return null;
                //throw new UserException("Wrong username or password!", System.Net.HttpStatusCode.BadRequest);
            }
            return Mapper.Map<Model.AppUser>(user);
        }

        //public async override Task<Model.AppUser> Insert(AppUserInsertRequest request)
        //{
        //    //var userExists = Context.AppUsers.FirstOrDefault(x => x.UserName == request.UserName);
        //    //if (userExists != null)
        //    //{
        //    //    throw new Exception("Username already exists!"); //napraviti odvojenu async funk
        //    //}
        //    if (await UsernameExists(request.UserName))
        //    {
        //        throw new Exception("Username already exists!");

        //    }
        //    if (request.Password != request.PasswordConfirm)
        //    {
        //        throw new Exception("Please confirm your password");
        //    }
        //    Database.AppUser user = Mapper.Map<Database.AppUser>(request);
        //    user.PasswordSalt = HashHelper.GenerateSalt();
        //    user.PasswordHash = HashHelper.GenerateHash(user.PasswordSalt, request.Password);

        //    await Context.AppUsers.AddAsync(user);
        //    await Context.SaveChangesAsync();
        //    return Mapper.Map<Model.AppUser>(user);
        //}

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

            //var userExists = Context.AppUsers.FirstOrDefault(x => x.UserName == request.UserName);
            //if (userExists != null)
            //{
            //    throw new UserException("Username already exists!"); //napraviti odvojenu async funk
            //}
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
        //public async override Task<Model.AppUser> Update(int id, AppUserUpdateRequest request)
        //{
        //    if (await UsernameExists(request.UserName))
        //    {
        //        throw new UserException("Username already exists!");
        //    }

        //    return await base.Update(id, request);
        //}

        public override IQueryable<AppUser> AddFilter(IQueryable<AppUser> query, AppUserSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrEmpty(search?.SearchText))
            {
                filteredQuery = filteredQuery.Where(x => x.FirstName.ToLower().StartsWith(search.SearchText.ToLower()) || x.LastName.ToLower().StartsWith(search.SearchText.ToLower()) || x.Email.ToLower().StartsWith(search.SearchText.ToLower()) || x.UserName.ToLower().StartsWith(search.SearchText.ToLower()));
            }


            //if (!string.IsNullOrEmpty(search?.LastName))
            //{
            //    filteredQuery = filteredQuery.Where(x => x.LastName.ToLower().StartsWith(search.LastName.ToLower()));
            //}

            //if (!string.IsNullOrEmpty(search?.Email))
            //{
            //    filteredQuery = filteredQuery.Where(x => x.Email.ToLower().StartsWith(search.Email.ToLower()));
            //}

            //if (!string.IsNullOrEmpty(search?.UserName))
            //{
            //    filteredQuery = filteredQuery.Where(x => x.UserName.ToLower().StartsWith(search.UserName.ToLower()));
            //}

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
        //private static ITransformer model = null;

        public async Task<List<Model.Attraction>> RecommendAttracions(int appUserId, int? categoryId = null)
        {
            //lock (isLocked)
            //{
            //    mlContext = new MLContext();

            //    //var tmpData = Context.Reviews.ToList();
            //    var tmpData = Context.Reviews.Where(x => x.TouristFacility.Attraction != null)
            //        .Include(x => x.TouristFacility)
            //        .Include(x => x.AppUser)
            //        .ToList();
            //    var data = new List<TouristFacilityRating>();

            //    foreach (var review in tmpData)
            //    {
            //        data.Add(new TouristFacilityRating
            //        {
            //            AppUserId = (uint)review.AppUserId,
            //            AttractionId = (uint)review.TouristFacilityId,
            //            Rating = review.Rating
            //        });
            //    }

            //    var trainingData = mlContext.Data.LoadFromEnumerable(data);

            //    var options = new MatrixFactorizationTrainer.Options
            //    {
            //        MatrixColumnIndexColumnName = "AppUserId",
            //        MatrixRowIndexColumnName = "AttractionId",
            //        LabelColumnName = "Rating",
            //        NumberOfIterations = 20,
            //        ApproximationRank = 100
            //    };

            //    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);


            //    model = est.Fit(trainingData);
            //    //model = est.Append(mlContext.Recommendation().Trainers.MatrixFactorization(options));
            //}

            var model = TrainData(true);

            var attractions = await Context.Attractions
                .Include(x=>x.IdNavigation)
                .Include(x=>x.IdNavigation.City)
                .Include(x=>x.IdNavigation.Category)
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
                System.Diagnostics.Debug.WriteLine(attraction.Id.ToString() + " - " + prediction.Score);
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1).Take(10).ToList();
            if(categoryId!=0)
                finalResult = finalResult.Where(x => x.IdNavigation.CategoryId == categoryId).ToList();

            return Mapper.Map<List<Model.Attraction>>(finalResult);
        }

        public async Task<List<Model.Event>> RecommendEvents(int appUserId, int? categoryId = null)
        {

            var model = TrainData(false);

            var events = await Context.Events
                .Include(x => x.IdNavigation)
                .Include(x => x.IdNavigation.City)
                .Include(x => x.IdNavigation.Category)
                .Include(x=>x.Agency)
                .Include(x=>x.AgencyMember)
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
                System.Diagnostics.Debug.WriteLine(x.Id.ToString() + " - " + prediction.Score);
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1).Take(10).ToList();

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
                    //.Include(x => x.TouristFacility)
                    //.Include(x => x.AppUser)
                    .ToList();
                }
                else
                {
                    tempData = Context.Reviews.Where(x => x.TouristFacility.Event != null)
                    //.Include(x => x.TouristFacility)
                    //.Include(x => x.AppUser)
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
                        _memoryCache.Set("attractionsModel", model, TimeSpan.FromMinutes(5));
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
                //model = est.Append(mlContext.Recommendation().Trainers.MatrixFactorization(options));
            }
        }


        public async void SendEmail(SendEmailRequest request)
        {
            var text = $"{request.AgencyName} added you as their member. This is your temporary password: {request.TempPass}. <br/> Please login and change your password to enjoy our app <br/> Your Visit Bosnia";
            await _emailSender.SendEmail(request.Email, $"Become {request.AgencyName} member", text);
        }

    }



}

