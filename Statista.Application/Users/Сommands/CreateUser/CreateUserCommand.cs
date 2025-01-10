using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Users.CreateUser;

public record CreateUserCommand(
    string Name,
    string Surname,
    string Nickname,
    string Email) : IRequest<User>;
