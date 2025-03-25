using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Users.CreateUser;

public record CreateUserCommand(
    string? Name,
    string? Surname,
    string Email) : IRequest<User>;
