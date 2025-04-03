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
        if ((await _userRepository.GetUserByEmail(command.Email)) is not null)
        {
            throw new Exception("User with this email already exists");
        }

        var user = new User
        {
            Id = Guid.NewGuid(),
            Name = command.FirstName,
            Email = command.Email,
            CreatedDate = DateTime.UtcNow,
            UpdatedDate = DateTime.UtcNow,
        };

        var passwordHash = new PasswordHasher<User>().HashPassword(user, command.Password);
        user.PasswordHash = passwordHash;
        await _userRepository.Add(user);
        var token = _jwtTokenGenerator.GenerateToken(user.Id);
        return new RegisterResult(user, token);
    }
}