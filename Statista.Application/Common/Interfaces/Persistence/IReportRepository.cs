using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IReportRepository
{
    Task<Report?> Add(Report report);
    Task<ICollection<Report>> GetReports();
    Task<ICollection<Report>> GetReportsByTypeId(Guid typeId);
    Task<Report?> GetReportById(Guid id);
    Task<ICollection<Report>> GetReportsByQuestionId(Guid id);
    Task<Report?> Update(Report report);
    Task<Report?> DeleteById(Guid id);
}