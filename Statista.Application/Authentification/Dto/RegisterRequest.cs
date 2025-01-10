
namespace Statista.Contracts.Authentication;

public record RegisterRequest(
    string Username,
    string? FirstName,
    string? LastName,
    string Email,
    string Password
);