using MediatR;

namespace Statista.Application.Features.Report.Queries.GetReportById;

public record GetReportByIdQuery(Guid id) : IRequest<ReportResponse>;