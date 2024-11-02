using MediatR;
using Statista.Application.Authentification.Queries.Login;

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
        if (_userRepository.GetUserByEmail(query.Email) is not UserEntity user)
        {
            throw new Exception("User with this email already exists");
        }

        if (user.Password != query.Password)
        {
            throw new Exception("Invalid password");
        }

        var token = _jwtTokenGenerator.GenerateToken(user.Id, user.FirstName, user.LastName);

        return new LoginResult(user, token);
    }
}