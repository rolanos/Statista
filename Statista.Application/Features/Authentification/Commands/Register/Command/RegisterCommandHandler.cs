using MediatR;
using Microsoft.AspNetCore.Identity;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Authentification.Commands.Register;

public class RegisterCommandHandler : IRequestHandler<RegisterCommand, RegisterResult>
{
    private readonly IJwtTokenGenerator _jwtTokenGenerator;

    private readonly IUserRepository _userRepository;

    public RegisterCommandHandler(IJwtTokenGenerator _jwtTokenGenerator, IUserRepository _userRepository)
    {
        this._jwtTokenGenerator = _jwtTokenGenerator;
        this._userRepository = _userRepository;
    }

    public async Task<RegisterResult> Handle(RegisterCommand command, CancellationToken cancellationToken)
    {
        if (_userRepository.GetUserByEmail(command.Email) is not null)
        {
            throw new Exception("User with this email already exists");
        }
        if (_userRepository.GetUserByUsername(command.Username) is not null)
        {
            throw new Exception("User with this Username already exists");
        }

        var user = new User(
            Guid.NewGuid(),
            command.Username,
            command.FirstName,
            command.LastName,
            command.Email,
            command.CreatedDate,
            command.CreatedDate);
        var passwordHash = new PasswordHasher<User>().HashPassword(user, command.Password);
        user.PasswordHash = passwordHash;
        await _userRepository.Add(user);
        var token = _jwtTokenGenerator.GenerateToken(user.Id, command.FirstName ?? command.Username, command.LastName ?? command.Email);
        return new RegisterResult(user, token);
    }
}