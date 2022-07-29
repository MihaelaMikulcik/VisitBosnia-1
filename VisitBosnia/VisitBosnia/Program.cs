using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using VisitBosnia.Filters;
using VisitBosnia.Security;
using VisitBosnia.Services;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;
//using VisitBosnia.Services.Interfaces;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

//builder.Services.AddControllers();
builder.Services.AddControllers(x=>x.Filters.Add<ExceptionFilter>());
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
    {
         {
             new OpenApiSecurityScheme
             {
                 Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
             },
             new string[]{}
         }
    });
});

builder.Services.AddTransient<ICityService, CityService>();
builder.Services.AddTransient<IEventService, EventService>();
builder.Services.AddTransient<ICategoryService, CategoryService>();
builder.Services.AddTransient<IAgencyService, AgencyService>();
builder.Services.AddTransient<IAgencyMemberService, AgencyMemberService>();

builder.Services.AddTransient<IAppUserRoleService, AppUserRoleService>();
builder.Services.AddTransient<IAppUserService, AppUserService>();
//builder.Services.AddTransient<IRoleService, RoleService>();
builder.Services.AddTransient<IReadService<VisitBosnia.Model.Role, object>, RoleService>();

builder.Services.AddAutoMapper(typeof(ICityService));
builder.Services.AddDbContext<VisitBosniaContext>(options => options
.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
