using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Users.CreateUser;

public record UpdateUserCommand(
    Guid Id,
    string Nickname,
    string Name,
    string Surname,
    string Email) : IRequest<User>;
