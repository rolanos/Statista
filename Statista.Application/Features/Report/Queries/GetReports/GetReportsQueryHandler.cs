using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Report.Queries.GetReports;

public class GetAllReportsQueryHandler : IRequestHandler<GetReportsQuery, ICollection<ReportResponse>>
{
    private readonly IReportRepository _reportRepository;

    private readonly IMapper _mapper;

    public GetAllReportsQueryHandler(IReportRepository reportRepository, IMapper mapper)
    {
        _reportRepository = reportRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<ReportResponse>> Handle(GetReportsQuery request, CancellationToken cancellationToken)
    {
        var reports = await _reportRepository.GetReports();
        var result = new List<ReportResponse>();
        foreach (var report in reports)
        {
            result.Add(_mapper.Map<ReportResponse>(report));
        }
        return result.AsReadOnly();
    }
}