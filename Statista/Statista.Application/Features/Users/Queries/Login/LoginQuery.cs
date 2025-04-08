using MediatR;

namespace Statista.Application.Authentification.Queries.Login;

public record LoginQuery(
    string Email,
    string Password) : IRequest<LoginResponse>;