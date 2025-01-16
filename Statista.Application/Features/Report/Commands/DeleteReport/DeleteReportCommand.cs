using MediatR;


namespace Statista.Application.Features.Report.Commands.DeleteReport;

public record DeleteReportCommand(Guid Id) : IRequest<ReportResponse>;