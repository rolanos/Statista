using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.ReportTypes.Dto;

namespace Statista.Application.Features.ReportTypes.Query.GetReportTypes;

public class GetAllReportsQueryHandler : IRequestHandler<GetReportTypesQuery, ICollection<ReportTypeResponse>>
{
    private readonly IReportTypeRepository _reportTypeRepository;

    private readonly IMapper _mapper;

    public GetAllReportsQueryHandler(IReportTypeRepository reportTypeRepository, IMapper mapper)
    {
        _reportTypeRepository = reportTypeRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<ReportTypeResponse>> Handle(GetReportTypesQuery request, CancellationToken cancellationToken)
    {
        var reportTypes = await _reportTypeRepository.GetReportTypes();
        var result = new List<ReportTypeResponse>();
        foreach (var reportType in reportTypes)
        {
            result.Add(_mapper.Map<ReportTypeResponse>(reportType));
        }
        return result.AsReadOnly();
    }
}