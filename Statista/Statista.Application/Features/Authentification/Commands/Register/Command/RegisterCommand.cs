using MediatR;

namespace Statista.Application.Authentification.Commands.Register;

public record RegisterCommand(
    string? FirstName,
    string? LastName,
    string Email,
    string Password,
    DateTime CreatedDate) : IRequest<RegisterResult>;