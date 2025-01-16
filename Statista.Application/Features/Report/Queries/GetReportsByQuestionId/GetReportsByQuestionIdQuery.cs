using MediatR;

namespace Statista.Application.Features.Report.Queries.GetReportsByQuestionId;

public record GetReportsByQuestionIdQuery(Guid questionId) : IRequest<ICollection<ReportResponse>>;