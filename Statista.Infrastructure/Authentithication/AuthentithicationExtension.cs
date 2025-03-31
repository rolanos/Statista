using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Microsoft.AspNetCore.Authorization;


namespace Statista.Infrastructure.Authentithication;

public static class AuthenticationExtension
{
    public static IServiceCollection AddCustomAuthentication(this IServiceCollection services, IConfiguration configuration)
    {
        var jwtSettings = configuration.GetSection(nameof(JwtSettings)).Get<JwtSettings>();
        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(opt =>
                {
                    opt.TokenValidationParameters = new TokenValidationParameters()
                    {
                        ValidateIssuer = false,
                        ValidateAudience = false,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.Secret))
                    };
                });
        // services.AddSingleton<IAuthorizationHandler, PermissionRequirementsHandler>();
        // services.AddAuthorizationBuilder()
        //     .AddPolicy(Permissions.Read, builder => builder.Requirements.Add(new PermissionRequirements(Permissions.Read)))
        //     .AddPolicy(Permissions.Create, builder => builder.Requirements.Add(new PermissionRequirements(Permissions.Create)))
        //     .AddPolicy(Permissions.Update, builder => builder.Requirements.Add(new PermissionRequirements(Permissions.Update)))
        //     .AddPolicy(Permissions.Delete, builder => builder.Requirements.Add(new PermissionRequirements(Permissions.Delete)));

        return services;
    }
}