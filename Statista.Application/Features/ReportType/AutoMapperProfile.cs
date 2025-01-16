using AutoMapper;
using Statista.Application.Features.ReportTypes.Dto;
using Statista.Application.Features.ReportTypes.Commands.UpdateReportType;
using Statista.Application.Features.ReportTypes.Commands.CreateReportType;

namespace Statista.Application.Features.ReportTypes;

public class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<Domain.Entities.ReportType, ReportTypeResponse>();
        CreateMap<CreateReportTypeRequest, CreateReportTypeCommand>();
        CreateMap<UpdateReportTypeRequest, UpdateReportTypeCommand>();
    }
}