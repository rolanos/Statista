using AutoMapper;
using Statista.Application.Features.Surveys.Dto;
using Statista.Application.Users.CreateUser;
using Statista.Application.Users.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Surveys;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<SurveyResponse, Survey>().ReverseMap();
    }
}