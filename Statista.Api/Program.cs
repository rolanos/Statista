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
app.UseSwagger(c =>
{
    c.PreSerializeFilters.Add((swaggerDoc, httpReq) =>
    {
        c.RouteTemplate = "api/swagger/swagger.json";
    });
});
app.UseSwaggerUI();

app.ApplyMigrations();

app.Run();

