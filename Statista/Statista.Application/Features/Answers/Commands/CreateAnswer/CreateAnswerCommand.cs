
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public record CreateAnswerCommand(Guid QuestionId, Guid AnswerValueId) : IRequest<Answer>;