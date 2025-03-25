using Microsoft.AspNetCore.Authorization;

namespace Statista.Infrastructure.Authentithication;

public class PermissionRequirements : IAuthorizationRequirement
{
    public string Permission { get; } = string.Empty;

    public PermissionRequirements(string permission)
    {
        Permission = permission;
    }
}