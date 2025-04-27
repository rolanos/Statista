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

    public async Task<ICollection<AdminGroup>> GetAdminGroupBySurveyId(Guid surveyId)
    {
        return await _dbContext.AdminGroup.AsNoTracking()
                                          .Where(a => a.SurveyId == surveyId)
                                          .ToListAsync();
    }
}