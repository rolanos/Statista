using MediatR;
using Statista.Application.Features.ReportTypes.Dto;

namespace Statista.Application.Features.ReportTypes.Commands.UpdateReportType;

public record UpdateReportTypeCommand : IRequest<ReportTypeResponse>
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public bool Critical { get; set; }
}