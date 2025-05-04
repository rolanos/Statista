
using MediatR;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public record CreateAnswerCommand(Guid QuestionId,
                                  ICollection<Guid> AnswerValueIds,
                                  Guid UserId) : IRequest<ICollection<Answer>>;