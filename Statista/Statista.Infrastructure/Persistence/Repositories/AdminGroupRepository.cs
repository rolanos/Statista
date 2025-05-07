using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Infrastructure.Persistence.Repositories;

class AdminGroupRepository : IAdminGroupRepository
{
    private readonly PostgresDbContext _dbContext;

    public AdminGroupRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<AdminGroup?> CreateAdminGroup(AdminGroup adminGroup)
    {
        await _dbContext.AddAsync(adminGroup);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.AdminGroup.SingleOrDefaultAsync(i => i.SurveyId == adminGroup.SurveyId
                                                                     && i.UserId == adminGroup.UserId);
    }

    public async Task<AdminGroup?> DeleteAdminGroup(AdminGroup adminGroup)
    {
        var adminGroupDb = await _dbContext.AdminGroup.AsNoTracking()
                                                    .SingleOrDefaultAsync(a => a.UserId == adminGroup.UserId && a.SurveyId == adminGroup.SurveyId);
        if (adminGroupDb is not null)
        {
            _dbContext.AdminGroup.Remove(adminGroup);
            await _dbContext.SaveChangesAsync();
            return adminGroupDb;
        }
        return null;
    }

    public async Task<ICollection<AdminGroup>> GetAdminGroupBySurveyId(Guid surveyId)
    {
        return await _dbContext.AdminGroup.AsNoTracking()
                                          .Where(a => a.SurveyId == surveyId)
                                          .Include(a => a.User)
                                          .ThenInclude(u => u.UserInfo)
                                          .Include(a => a.Role)
                                          .ToListAsync();
    }

    public async Task<AdminGroup?> UpdateAdmin(AdminGroup adminGroup)
    {
        _dbContext.AdminGroup.Update(adminGroup);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.AdminGroup.SingleOrDefaultAsync(a => a.UserId == adminGroup.UserId && a.SurveyId == adminGroup.SurveyId);
    }
}