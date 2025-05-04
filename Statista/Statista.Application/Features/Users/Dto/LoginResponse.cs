using Statista.Application.Users.Dto;

public record LoginResponse(UserResponse User, string Token);