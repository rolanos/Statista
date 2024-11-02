namespace Statista.Application.Authentification.Queries.Login;

public record LoginResult(UserEntity User, string Token);