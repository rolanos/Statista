using AutoMapper;
using Statista.Application.Features.Questions.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Questions;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<Question, QuestionResponse>().ReverseMap();
    }
}