using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Constants;

namespace Statista.Infrastructure.Persistence;

public static class DataSeedExtension
{
    public static async Task<IApplicationBuilder> AddSeeds(this IApplicationBuilder app)
    {

        var serviceScope = app.ApplicationServices.GetRequiredService<IServiceScopeFactory>().CreateScope();
        await serviceScope.ServiceProvider.SeedDatabaseAsync();
        return app;
    }
    public static async Task<IServiceProvider> SeedDatabaseAsync(this IServiceProvider services)
    {
        var dataSeeder = new DataSeeder(services);
        await dataSeeder.Seed();
        return services;
    }
}

public class DataSeeder
{

    private readonly IServiceProvider _services;

    public DataSeeder(IServiceProvider services)
    {
        _services = services;
    }

    public async Task Seed()
    {
        await InsertReportTypes();
    }

    private async Task InsertReportTypes()
    {
        var _reportTypesRepository = _services.GetRequiredService<IReportTypeRepository>();
        if (!_reportTypesRepository.HasData())
        {
            foreach (var item in ReportTypeConstant.values)
            {
                await _reportTypesRepository.Add(item);
            }
        }
    }
}