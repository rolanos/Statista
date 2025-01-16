using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Report.Commands.DeleteReport;

public class DeleteReportCommandHandler : IRequestHandler<DeleteReportCommand, ReportResponse>
{
    private readonly IReportRepository _reportRepository;

    private readonly IMapper _mapper;

    public DeleteReportCommandHandler(IReportRepository reportRepository, IMapper mapper)
    {
        _reportRepository = reportRepository;
        _mapper = mapper;
    }

    public async Task<ReportResponse> Handle(DeleteReportCommand request, CancellationToken cancellationToken)
    {
        var report = await _reportRepository.DeleteById(request.Id);
        if (report == null)
        {
            throw new Exception("Report not found");
        }
        return _mapper.Map<ReportResponse>(report);
    }
}