using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.ReportTypes.Dto;

namespace Statista.Application.Features.ReportTypes.Commands.UpdateReportType;

public class UpdateReportTypeCommandHandler : IRequestHandler<UpdateReportTypeCommand, ReportTypeResponse>
{
    private readonly IReportTypeRepository _reportTypeRepository;

    private readonly IMapper _mapper;

    public UpdateReportTypeCommandHandler(IReportTypeRepository reportTypeRepository, IMapper mapper)
    {
        _reportTypeRepository = reportTypeRepository;
        _mapper = mapper;
    }

    public async Task<ReportTypeResponse> Handle(UpdateReportTypeCommand request, CancellationToken cancellationToken)
    {
        var reportTypeOld = await _reportTypeRepository.GetReportTypeById(request.Id);
        if (reportTypeOld == null)
        {
            throw new Exception("Report type not found");
        }
        var newReportType = new Domain.Entities.ReportType
        {
            Id = request.Id,
            Name = request.Name,
            Critical = request.Critical,
        };
        var reportType = await _reportTypeRepository.Update(newReportType);
        if (reportType == null)
        {
            throw new Exception("Report type not created");
        }
        return _mapper.Map<ReportTypeResponse>(reportType);
    }
}