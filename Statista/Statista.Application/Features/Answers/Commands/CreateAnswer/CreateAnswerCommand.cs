
using MediatR;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public record CreateAnswerCommand(Guid QuestionId,
                                  Guid AnswerValueId,
                                  Guid UserId) : IRequest<Answer>;