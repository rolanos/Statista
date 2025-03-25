using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IPermissionRepository
{
    Task<Permission?> Add(Permission question);
    Task<ICollection<Permission>> GetPermissions();
    bool HasData();
}