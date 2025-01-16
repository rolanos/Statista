using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IReportTypeRepository
{
    Task<ReportType?> Add(ReportType reportType);
    Task<ICollection<ReportType>> GetReportTypes();
    Task<ReportType?> GetReportTypeById(Guid id);
    Task<ReportType?> Update(ReportType reportType);
}