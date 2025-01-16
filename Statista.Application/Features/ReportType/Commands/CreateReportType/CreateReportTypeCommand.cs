using MediatR;
using Statista.Application.Features.ReportTypes.Dto;

namespace Statista.Application.Features.ReportTypes.Commands.CreateReportType;

public record CreateReportTypeCommand : IRequest<ReportTypeResponse>
{
    public string Name { get; set; }
    public bool Critical { get; set; }
}