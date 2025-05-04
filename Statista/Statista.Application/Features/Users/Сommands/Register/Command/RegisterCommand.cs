using MediatR;

namespace Statista.Application.Authentification.Commands.Register;

public record RegisterCommand(string Email, string Password) : IRequest<LoginResponse>;