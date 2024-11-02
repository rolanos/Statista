using MediatR;

namespace Statista.Application.Authentification.Commands.Register;

public class LoginCommandHandler : IRequestHandler<RegisterCommand, RegisterResult>
{
    private readonly IJwtTokenGenerator _jwtTokenGenerator;

    private readonly IUserRepository _userRepository;

    public LoginCommandHandler(IJwtTokenGenerator _jwtTokenGenerator, IUserRepository _userRepository)
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

        var user = new UserEntity
        {
            FirstName = command.FirstName,
            LastName = command.LastName,
            Email = command.Email,
            Password = command.Password,
        };
        _userRepository.Add(user);
        var token = _jwtTokenGenerator.GenerateToken(user.Id, command.FirstName, command.LastName);
        return new RegisterResult(user, token);
    }
}