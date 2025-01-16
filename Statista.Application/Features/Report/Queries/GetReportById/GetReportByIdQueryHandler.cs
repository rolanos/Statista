using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Report.Queries.GetReportById;

public class GetAllReportByIdQueryHandler : IRequestHandler<GetReportByIdQuery, ReportResponse>
{
    private readonly IReportRepository _reportRepository;

    private readonly IMapper _mapper;

    public GetAllReportByIdQueryHandler(IReportRepository reportRepository, IMapper mapper)
    {
        _reportRepository = reportRepository;
        _mapper = mapper;
    }

    public async Task<ReportResponse> Handle(GetReportByIdQuery request, CancellationToken cancellationToken)
    {
        var report = await _reportRepository.GetReportById(request.id);
        if (report == null)
        {
            throw new Exception("Report not found");
        }
        return _mapper.Map<ReportResponse>(report);
    }
}