using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.ReportTypes.Dto;

namespace Statista.Application.Features.ReportTypes.Commands.CreateReportType;

public class CreateReportTypeCommandHandler : IRequestHandler<CreateReportTypeCommand, ReportTypeResponse>
{
    private readonly IReportTypeRepository _reportTypeRepository;

    private readonly IMapper _mapper;

    public CreateReportTypeCommandHandler(IReportTypeRepository reportTypeRepository, IMapper mapper)
    {
        _reportTypeRepository = reportTypeRepository;
        _mapper = mapper;
    }

    public async Task<ReportTypeResponse> Handle(CreateReportTypeCommand request, CancellationToken cancellationToken)
    {
        var newReportType = new Domain.Entities.ReportType
        {
            Id = Guid.NewGuid(),
            Name = request.Name,
            Critical = request.Critical,
        };
        var reportType = await _reportTypeRepository.Add(newReportType);
        if (reportType == null)
        {
            throw new Exception("Report type not created");
        }
        return _mapper.Map<ReportTypeResponse>(reportType);
    }
}