using Microsoft.EntityFrameworkCore;
using VisitBosnia.Services;
using VisitBosnia.Services.Database;
using VisitBosnia.Services.Interfaces;
//using VisitBosnia.Services.Interfaces;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddTransient<ICityService, CityService>();

builder.Services.AddAutoMapper(typeof(ICityService));
builder.Services.AddDbContext<VisitBosniaContext>(options => options
.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
