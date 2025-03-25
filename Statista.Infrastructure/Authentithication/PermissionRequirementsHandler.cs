using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.DependencyInjection;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Infrastructure.Authentithication;

public class PermissionRequirementsHandler : AuthorizationHandler<PermissionRequirements>
{
    private readonly IServiceScopeFactory _serviceScope;

    public PermissionRequirementsHandler(IServiceScopeFactory serviceScope)
    {
        _serviceScope = serviceScope;
    }
    protected async override Task HandleRequirementAsync(
        AuthorizationHandlerContext context,
        PermissionRequirements requirement)
    {
        var userId = context.User.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Sub);
        var userIdParsed = Guid.Parse(userId?.Value ?? "");
        var scope = _serviceScope.CreateScope();
        var userRepository = scope.ServiceProvider.GetService<IUserRepository>();
        if (userId != null)
        {
            var permissions = userRepository != null ? await userRepository.GetPermissions(userIdParsed) : new List<Permission>();
            if (permissions != null && permissions.Any(x => x.Name == requirement.Permission))
            {
                context.Succeed(requirement);
            }
        }
    }
}