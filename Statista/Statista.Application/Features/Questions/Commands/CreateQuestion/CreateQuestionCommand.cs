
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public record CreateQuestionCommand(
    string Title,
    Guid? PastQuestion,
    Guid TypeId,
    Guid? SectionId,
    bool isGeneral = false) : IRequest<Question>;