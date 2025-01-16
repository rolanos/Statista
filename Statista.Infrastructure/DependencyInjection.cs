
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Infrastructure.Authentithication;
using Statista.Infrastructure.Persistence;
using Statista.Infrastructure.Persistence.Repositories;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, ConfigurationManager configuration)
    {
        var connectionString = configuration.GetConnectionString("DbConnectionLocal");
        services.Configure<JwtSettings>(configuration.GetSection(JwtSettings.SectionName));
        services.AddSingleton<IJwtTokenGenerator, JwtTokenGenerator>();
        services.AddSingleton<IDateTimeProvider, DateTimeProvider>();
        services.AddPersistence();
        services.AddDbContext<PostgresDbContext>(options => options.UseNpgsql(connectionString));
        services.AddCustomAuthentication(configuration);
        return services;
    }

    public static IServiceCollection AddPersistence(this IServiceCollection services)
    {
        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<IReportRepository, ReportRepository>();
        services.AddScoped<IReportTypeRepository, ReportTypeRepository>();
        services.AddScoped<IQuestionRepository, QuestionRepository>();
        return services;
    }

}