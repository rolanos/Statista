
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public record CreateQuestionCommand(
    string Title,
    Guid FormId,
    Guid SectionId) : IRequest<Question>;