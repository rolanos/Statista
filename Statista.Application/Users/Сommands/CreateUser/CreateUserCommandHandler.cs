using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Users.CreateUser;

public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand, User>
{
    private readonly IUserRepository _userRepository;

    private IMapper _mapper;
    public CreateUserCommandHandler(IMapper mapper, IUserRepository userRepository)
    {
        _mapper = mapper;
        _userRepository = userRepository;
    }

    public async Task<User> Handle(CreateUserCommand request, CancellationToken cancellationToken)
    {
        var newUser = new User(
            Guid.NewGuid(),
            request.Nickname,
            request.Name,
            request.Surname,
            request.Email,
            DateTime.UtcNow,
            DateTime.UtcNow);
        await _userRepository.Add(newUser);
        return newUser;
    }
}