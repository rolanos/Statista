using MediatR;

namespace Statista.Application.Features.Report.Commands.UpdateReport;

public record UpdateReportCommand : IRequest<ReportResponse>
{
    public Guid Id { get; set; }
    public Guid ReportTypeId { get; set; }
    public Guid ReportedQuestionId { get; set; }
    public string Message { get; set; }
    public Guid CreatedById { get; set; }
}
