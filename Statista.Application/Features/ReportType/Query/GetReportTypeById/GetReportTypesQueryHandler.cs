using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.ReportTypes.Dto;

namespace Statista.Application.Features.ReportTypes.Query.GetReportTypesById;

public class GetAllReportsQueryHandler : IRequestHandler<GetReportTypeByIdQuery, ReportTypeResponse>
{
    private readonly IReportTypeRepository _reportTypeRepository;

    private readonly IMapper _mapper;

    public GetAllReportsQueryHandler(IReportTypeRepository reportTypeRepository, IMapper mapper)
    {
        _reportTypeRepository = reportTypeRepository;
        _mapper = mapper;
    }

    public async Task<ReportTypeResponse> Handle(GetReportTypeByIdQuery request, CancellationToken cancellationToken)
    {
        var reportType = await _reportTypeRepository.GetReportTypeById(request.Id);
        if (reportType == null)
        {
            throw new Exception("Report type not found");
        }
        return _mapper.Map<ReportTypeResponse>(reportType);
    }
}