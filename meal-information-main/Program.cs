using System.Data.SqlClient;
using MealInformation.Models;
using MealInformation.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add AutoMapper for dependency injection
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

// Add app specific services to DI container
builder.Services.AddScoped<MealPlanService>();
builder.Services.AddScoped<DataService>();

// Database connection
string connectionString = GetConnectionString();
var serverVersion = new MySqlServerVersion(new Version(8, 0, 26));
builder.Services.AddDbContext<GibzDbContext>(
    dbContextOptions => dbContextOptions.UseMySql(connectionString, serverVersion)
);

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

string GetConnectionString()
{
    var connectionString = new SqlConnectionStringBuilder()
    {
        DataSource = Environment.GetEnvironmentVariable("DB_HOST"),     // e.g. '127.0.0.1'
                                                                        // Set Host to 'cloudsql' when deploying to App Engine Flexible environment
        UserID = Environment.GetEnvironmentVariable("DB_USER"),         // e.g. 'my-db-user'
        Password = Environment.GetEnvironmentVariable("DB_PASS"),       // e.g. 'my-db-password'
        InitialCatalog = Environment.GetEnvironmentVariable("DB_NAME"), // e.g. 'my-database'
    };

    return connectionString.ConnectionString;
}