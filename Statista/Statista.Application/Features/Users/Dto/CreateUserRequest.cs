namespace Statista.Application.Users.Dto;

public record CreateUserRequest(
    string Name,
    string Surname,
    string Nickname,
    string Email);