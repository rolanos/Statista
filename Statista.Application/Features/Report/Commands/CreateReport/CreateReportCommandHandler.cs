using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Report.Commands.CreateReport;

public class CreateReportCommandHandler : IRequestHandler<CreateReportCommand, ReportResponse>
{
    private readonly IReportRepository _reportRepository;
    private readonly IReportTypeRepository _reportTypeRepository;
    private readonly IUserRepository _userRepository;
    private readonly IQuestionRepository _questionRepository;
    private readonly IMapper _mapper;

    public CreateReportCommandHandler(
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

    public async Task<ReportResponse> Handle(CreateReportCommand request, CancellationToken cancellationToken)
    {
        var type = await _reportTypeRepository.GetReportTypeById(request.ReportTypeId);
        if (type is null)
        {
            throw new Exception("Report type was not found at creation new report");
        }
        var question = await _questionRepository.GetQuestionById(request.ReportedQuestionId);
        if (question is null)
        {
            throw new Exception("Reported question was not found at creation new report");
        }
        var user = await _userRepository.GetUserById(request.CreatedById);
        if (user is null)
        {
            throw new Exception("User was not found at creation new report");
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
        var report = await _reportRepository.Add(newReport);
        return _mapper.Map<ReportResponse>(report);
    }
}