using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Report.Queries.GetReportsByQuestionId;

public class GetReportsByQuestionIdQueryHandler : IRequestHandler<GetReportsByQuestionIdQuery, ICollection<ReportResponse>>
{
    private readonly IReportRepository _reportRepository;

    private readonly IMapper _mapper;

    public GetReportsByQuestionIdQueryHandler(IReportRepository reportRepository, IMapper mapper)
    {
        _reportRepository = reportRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<ReportResponse>> Handle(GetReportsByQuestionIdQuery request, CancellationToken cancellationToken)
    {
        var reports = await _reportRepository.GetReportsByQuestionId(request.questionId);
        var result = new List<ReportResponse>();
        foreach (var report in reports)
        {
            result.Add(_mapper.Map<ReportResponse>(report));
        }
        return result.AsReadOnly();
    }
}