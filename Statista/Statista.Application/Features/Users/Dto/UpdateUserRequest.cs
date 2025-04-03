namespace Statista.Application.Users.Dto;

public record UpdateUserRequest(
    Guid Id,
    string Nickname,
    string Name,
    string Surname,
    string Email);