using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Users.Dto;

namespace Statista.Application.Users.Queries.GetUsers;

public class GetUsersQueryHandler : IRequestHandler<GetUsersQuery, IReadOnlyList<UserResponse>>
{
    private readonly IUserRepository _userRepository;

    private readonly IMapper _mapper;

    public GetUsersQueryHandler(IUserRepository userRepository, IMapper mapper)
    {
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<IReadOnlyList<UserResponse>> Handle(GetUsersQuery request, CancellationToken cancellationToken)
    {
        var users = _userRepository.GetUsers();
        var result = new List<UserResponse>();
        foreach (var user in users)
        {
            result.Add(_mapper.Map<UserResponse>(user));
        }
        return result.AsReadOnly();
    }
}