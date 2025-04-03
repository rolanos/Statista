using MediatR;
using Statista.Application.Features.Questions.Dto;
using Statista.Application.Features.Sections.Dto;

namespace Statista.Application.Features.Questions.Queries.GetQuestionsBySectionId;

public record GetQuestionsBySectionIdQuery(Guid SectionId) : IRequest<ICollection<QuestionResponse>>;