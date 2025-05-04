using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Statista.Application.Authentification.Queries.Login;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Users.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Authentification.Commands.Login;

public class LoginQueryHandler : IRequestHandler<LoginQuery, LoginResponse>
{
    private readonly IJwtTokenGenerator _jwtTokenGenerator;

    private readonly IUserRepository _userRepository;

    private readonly IMapper _mapper;

    public LoginQueryHandler(
        IJwtTokenGenerator jwtTokenGenerator,
        IUserRepository userRepository,
        IMapper mapper)
    {
        _jwtTokenGenerator = jwtTokenGenerator;
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<LoginResponse> Handle(LoginQuery query, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserByEmail(query.Email);
        if (user is null)
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
            var token = _jwtTokenGenerator.GenerateToken(user.Id);
            return new LoginResponse(_mapper.Map<UserResponse>(user!), token);
        }
        else
        {
            throw new Exception("Auth error");
        }
    }
}