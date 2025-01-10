
using Statista.Domain.Entities;

namespace Statista.Application.Authentification.Commands.Register;

public record RegisterResult(User User, string Token);