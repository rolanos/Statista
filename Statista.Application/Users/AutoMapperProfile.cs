using AutoMapper;
using Statista.Application.Users.CreateUser;
using Statista.Application.Users.Dto;
using Statista.Domain.Entities;


namespace Statista.Application.Menus;
internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<CreateUserRequest, CreateUserCommand>();
        CreateMap<UpdateUserRequest, UpdateUserCommand>();
        CreateMap<User, UserResponse>();
    }
}