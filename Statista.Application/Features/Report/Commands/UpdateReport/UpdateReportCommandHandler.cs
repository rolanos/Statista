using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Report.Commands.UpdateReport;

namespace Statista.Application.Features.Report.Commands.UpdateReport;

public class UpdateReportCommandHandler : IRequestHandler<UpdateReportCommand, ReportResponse>
{
    private readonly IReportRepository _reportRepository;
    private readonly IReportTypeRepository _reportTypeRepository;
    private readonly IUserRepository _userRepository;
    private readonly IQuestionRepository _questionRepository;
    private readonly IMapper _mapper;

    public UpdateReportCommandHandler(
        IReportRepository reportRepository,
        IReportTypeRepository reportTypeRepository,
        IUserRepository userRepository,
        IQuestionRepository questionRepository,
        IMapper mapper)
    {
        _reportRepository = reportRepository;
        _reportTypeRepository = reportTypeRepository;
        _userRepository = userRepository;
        _questionRepository = questionRepository;
        _mapper = mapper;
    }

    public async Task<ReportResponse> Handle(UpdateReportCommand request, CancellationToken cancellationToken)
    {
        var report = await _reportRepository.GetReportById(request.Id);
        if (report is null)
        {
            throw new Exception("Report was not found at updating new report");
        }

        var type = await _reportTypeRepository.GetReportTypeById(request.ReportTypeId);
        if (type is null)
        {
            throw new Exception("Report type was not found at updating new report");
        }

        var question = await _questionRepository.GetQuestionById(request.ReportedQuestionId);
        if (question is null)
        {
            throw new Exception("Reported question was not found at updating new report");
        }

        var user = await _userRepository.GetUserById(request.CreatedById);
        if (user is null)
        {
            throw new Exception("User was not found at updating new report");
        }

        var newReport = new Domain.Entities.Report
        {
            Id = Guid.NewGuid(),
            ReportTypeId = request.ReportTypeId,
            ReportType = type,
            ReportedQuestionId = request.ReportedQuestionId,
            ReportedQuestion = question,
            Message = request.Message,
            CreatedById = request.CreatedById,
            CreatedBy = user,
        };
        var updatedReport = await _reportRepository.Update(newReport);
        return _mapper.Map<ReportResponse>(updatedReport);
    }
}