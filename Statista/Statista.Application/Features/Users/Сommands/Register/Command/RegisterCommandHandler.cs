using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Users.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Authentification.Commands.Register;

public class RegisterCommandHandler : IRequestHandler<RegisterCommand, LoginResponse>
{
    private readonly IJwtTokenGenerator _jwtTokenGenerator;

    private readonly IUserRepository _userRepository;

    private readonly IMapper _mapper;

    public RegisterCommandHandler(
        IJwtTokenGenerator jwtTokenGenerator,
        IUserRepository userRepository,
        IMapper mapper)
    {
        _jwtTokenGenerator = jwtTokenGenerator;
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<LoginResponse> Handle(RegisterCommand command, CancellationToken cancellationToken)
    {
        if ((await _userRepository.GetUserByEmail(command.Email)) is not null)
        {
            throw new Exception("User with this email already exists");
        }

        var user = new User
        {
            Id = Guid.NewGuid(),
            Email = command.Email,
            CreatedDate = DateTime.UtcNow,
            UpdatedDate = DateTime.UtcNow,
        };

        var passwordHash = new PasswordHasher<User>().HashPassword(user, command.Password);
        user.PasswordHash = passwordHash;
        await _userRepository.Add(user);
        var token = _jwtTokenGenerator.GenerateToken(user.Id);
        return new LoginResponse(_mapper.Map<UserResponse>(user), token);
    }
}