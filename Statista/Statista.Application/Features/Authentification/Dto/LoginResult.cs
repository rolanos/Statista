using Statista.Domain.Entities;

namespace Statista.Application.Authentification.Queries.Login;

public record LoginResult(User User, string Token);