using MediatR;
using Microsoft.AspNetCore.Identity;
using Statista.Application.Authentification.Queries.Login;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Authentification.Commands.Login;

public class LoginCommandHandler : IRequestHandler<LoginQuery, LoginResult>
{
    private readonly IJwtTokenGenerator _jwtTokenGenerator;

    private readonly IUserRepository _userRepository;

    public LoginCommandHandler(IJwtTokenGenerator _jwtTokenGenerator, IUserRepository _userRepository)
    {
        this._jwtTokenGenerator = _jwtTokenGenerator;
        this._userRepository = _userRepository;
    }

    public async Task<LoginResult> Handle(LoginQuery query, CancellationToken cancellationToken)
    {
        if (_userRepository.GetUserByEmail(query.Email) is not User user)
        {
            throw new Exception("User with this email already exists");
        }

        if (user is null)
        {
            throw new Exception("User is null");
        }

        if (user.PasswordHash != null)
        {
            var hashCompareResult = new PasswordHasher<User>().VerifyHashedPassword(user, user.PasswordHash, query.Password);
            if (hashCompareResult == PasswordVerificationResult.Failed)
            {
                throw new Exception("Invalid password");
            }
            var token = _jwtTokenGenerator.GenerateToken(user.Id, user.Name ?? "empty_name", user.Surname ?? "empty_surname");
            return new LoginResult(user!, token);
        }
        else
        {
            throw new Exception("Auth error");
        }
    }
}