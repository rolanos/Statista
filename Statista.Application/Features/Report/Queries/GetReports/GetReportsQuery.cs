using MediatR;

namespace Statista.Application.Features.Report.Queries.GetReports;

public record GetReportsQuery() : IRequest<ICollection<ReportResponse>>;