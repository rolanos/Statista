using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Users.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Users.Queries.GetUsers;

public class GetSurveysQueryHandler : IRequestHandler<GetUsersQuery, ICollection<UserResponse>>
{
    private readonly IUserRepository _userRepository;

    private readonly IMapper _mapper;

    public GetSurveysQueryHandler(IUserRepository userRepository, IMapper mapper)
    {
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<UserResponse>> Handle(GetUsersQuery request, CancellationToken cancellationToken)
    {
        var users = await _userRepository.GetUsers();
        var result = new List<UserResponse>();
        if (users == null)
        {
            return [];
        }
        foreach (var user in users)
        {
            result.Add(_mapper.Map<UserResponse>(user));
        }
        return result.AsReadOnly();
    }
}