using AutoMapper;
using Statista.Application.Features.Report.Commands.CreateReport;

namespace Statista.Application.Features;

public class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<Domain.Entities.Report, ReportResponse>();
        CreateMap<CreateReportRequest, CreateReportCommand>();
    }
}