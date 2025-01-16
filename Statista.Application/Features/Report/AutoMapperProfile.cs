using AutoMapper;

namespace Statista.Application.Features;

public class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<Domain.Entities.Report, ReportResponse>();
    }
}