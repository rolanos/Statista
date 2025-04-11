
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public record CreateFormCommand(
    string Name,
    string Description,
    Guid CreatedById) : IRequest<Form>;