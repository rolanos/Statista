using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;

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
        //await InsertPerissions();
    }

    // private async Task InsertPerissions()
    // {
    //     var _permissionsRepository = _services.GetRequiredService<IPermissionRepository>();
    //     if (!_permissionsRepository.HasData())
    //     {
    //         foreach (var item in PermissionConstant.values)
    //         {
    //             await _permissionsRepository.Add(item);
    //         }
    //     }
    // }
}