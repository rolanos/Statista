using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class ReportRepository : IReportRepository
{
    private readonly PostgresDbContext _dbContext;

    public ReportRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Report?> Add(Report report)
    {
        await _dbContext.AddAsync(report);

        await _dbContext.SaveChangesAsync();

        return await GetReportById(report.Id);
    }

    public async Task<Report?> DeleteById(Guid id)
    {
        var report = await GetReportById(id);
        if (report is not null)
        {
            _dbContext.Reports.Remove(report);
            await _dbContext.SaveChangesAsync();
            return report;
        }
        return null;
    }

    public async Task<Report?> GetReportById(Guid id)
    {
        return await _dbContext.Reports.SingleOrDefaultAsync(u => u.Id == id);
    }

    public async Task<ICollection<Report>> GetReports()
    {
        return await _dbContext.Reports.ToListAsync();
    }

    public async Task<ICollection<Report>> GetReportsByQuestionId(Guid id)
    {
        return await _dbContext.Reports.Where(u => u.ReportedQuestionId == id).ToListAsync();
    }

    public async Task<ICollection<Report>> GetReportsByTypeId(Guid typeId)
    {
        return await _dbContext.Reports.Where(u => u.ReportTypeId == typeId).ToListAsync();
    }

    public async Task<Report?> Update(Report report)
    {
        var oldElement = await GetReportById(report.Id);
        if (oldElement is null)
        {
            throw new Exception("In DataBase no Report with this Id");
        }

        _dbContext.Entry(oldElement).CurrentValues.SetValues(report);

        await _dbContext.SaveChangesAsync();

        return await GetReportById(report.Id);
    }
}