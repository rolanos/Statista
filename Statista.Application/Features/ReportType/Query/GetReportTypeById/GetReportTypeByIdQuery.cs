using MediatR;
using Statista.Application.Features.ReportTypes.Dto;

namespace Statista.Application.Features.ReportTypes.Query.GetReportTypesById;

public record GetReportTypeByIdQuery(Guid Id) : IRequest<ReportTypeResponse>;