using System.Xml.XPath;
using Microsoft.OpenApi.Models;
using Statista.Infrastructure.Persistence;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddInfrastructure(builder.Configuration);
builder.Services.AddApplication();
builder.Services.AddControllers();

var app = builder.Build();

app.UseMiddleware<ErrorHandlingMiddleware>();
//app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.ApplyMigrations();
app.AddSeeds().GetAwaiter().GetResult();

if (app.Environment.IsDevelopment()) { }
app.UseSwagger();

app.UseSwaggerUI(c =>
            {

                //  c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
                c.SwaggerEndpoint("v1/swagger.json", "Route");
                //c.SwaggerEndpoint("swagger/v1/swagger.json", "My API V1");
            });

app.ApplyMigrations();

app.Run();

