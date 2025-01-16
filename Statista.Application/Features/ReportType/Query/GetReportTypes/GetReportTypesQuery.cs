using MediatR;
using Statista.Application.Features.ReportTypes.Dto;

namespace Statista.Application.Features.ReportTypes.Query.GetReportTypes;

public record GetReportTypesQuery() : IRequest<ICollection<ReportTypeResponse>>;