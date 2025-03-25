using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Infrastructure.Persistence.Repositories;

public class PermissionRepository : IPermissionRepository
{
    private readonly PostgresDbContext _dbContext;

    public PermissionRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Permission?> Add(Permission permission)
    {
        var addedPermission = await _dbContext.AddAsync(permission);

        await _dbContext.SaveChangesAsync();

        return addedPermission.Entity;
    }

    public async Task<ICollection<Permission>> GetPermissions()
    {
        return await _dbContext.Permissions.ToListAsync();
    }

    public bool HasData()
    {
        return _dbContext.Permissions.Any();
    }
}