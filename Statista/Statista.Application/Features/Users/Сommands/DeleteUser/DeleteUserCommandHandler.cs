using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Users.CreateUser;

public class DeleteUserByUsernameHandler : IRequestHandler<DeleteUserCommand, User>
{
    private readonly IUserRepository _userRepository;

    private IMapper _mapper;
    public DeleteUserByUsernameHandler(IMapper mapper, IUserRepository userRepository)
    {
        _mapper = mapper;
        _userRepository = userRepository;
    }

    public async Task<User> Handle(DeleteUserCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.DeleteUserById(request.id);
        if (user is null)
        {
            throw new Exception("User not deleted");
        }
        return user;
    }
}