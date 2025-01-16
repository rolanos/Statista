using MediatR;

namespace Statista.Application.Features.Report.Commands.CreateReport;

public record CreateReportCommand : IRequest<ReportResponse>
{
    public Guid ReportTypeId { get; set; }
    public Guid ReportedQuestionId { get; set; }
    public string Message { get; set; }
    public Guid CreatedById { get; set; }
}
