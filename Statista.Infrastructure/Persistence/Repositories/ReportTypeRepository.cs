using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class ReportTypeRepository : IReportTypeRepository
{
    private readonly PostgresDbContext _dbContext;

    public ReportTypeRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<ReportType?> Add(ReportType reportType)
    {
        await _dbContext.AddAsync(reportType);

        await _dbContext.SaveChangesAsync();

        return await GetReportTypeById(reportType.Id);
    }

    public async Task<ReportType?> GetReportTypeById(Guid id)
    {
        return await _dbContext.ReportTypes.SingleOrDefaultAsync(u => u.Id == id);
    }

    public async Task<ICollection<ReportType>> GetReportTypes()
    {
        return await _dbContext.ReportTypes.ToListAsync();
    }

    public async Task<ReportType?> Update(ReportType reportType)
    {
        var oldElement = await GetReportTypeById(reportType.Id);
        if (oldElement is null)
        {
            throw new Exception("In DataBase no Report Type with this Id");
        }

        _dbContext.Entry(oldElement).CurrentValues.SetValues(reportType);

        await _dbContext.SaveChangesAsync();

        return await GetReportTypeById(reportType.Id);
    }
}