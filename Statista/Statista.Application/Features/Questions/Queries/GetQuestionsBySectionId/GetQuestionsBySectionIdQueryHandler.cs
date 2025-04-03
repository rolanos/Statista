using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Dto;
using Statista.Application.Features.Questions.Queries.GetQuestionsBySectionId;
using Statista.Application.Features.Sections.Dto;

namespace Statista.Application.Features.Surveys.Queries.GetSurveys;

public class GetQuestionsBySectionIdQueryHandler : IRequestHandler<GetQuestionsBySectionIdQuery, ICollection<QuestionResponse>>
{
    private readonly IQuestionRepository _questionRepository;

    private readonly IMapper _mapper;

    public GetQuestionsBySectionIdQueryHandler(IQuestionRepository questionRepository, IMapper mapper)
    {
        _questionRepository = questionRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<QuestionResponse>> Handle(GetQuestionsBySectionIdQuery request, CancellationToken cancellationToken)
    {
        var surveys = await _questionRepository.GetQuestionsBySectionId(request.SectionId);
        var result = new List<QuestionResponse>();
        foreach (var survey in surveys)
        {
            result.Add(_mapper.Map<QuestionResponse>(survey));
        }
        return result.AsReadOnly();
    }
}