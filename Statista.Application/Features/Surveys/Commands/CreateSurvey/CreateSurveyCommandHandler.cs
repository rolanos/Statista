using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Surveys.CreateSurvey;

public class CreateSurveyCommandHandler : IRequestHandler<CreateSurveyCommand, Survey>
{
    private readonly ISurveyRepository _surveyRepository;

    private IMapper _mapper;
    public CreateSurveyCommandHandler(IMapper mapper, ISurveyRepository surveyRepository)
    {
        _mapper = mapper;
        _surveyRepository = surveyRepository;
    }

    public async Task<Survey> Handle(CreateSurveyCommand request, CancellationToken cancellationToken)
    {
        var survey = new Survey
        {
            Id = Guid.NewGuid(),
        };
        var newSurvey = await _surveyRepository.CreateSurvey(survey);
        if (newSurvey is null)
        {
            throw new Exception("Survey have not created");
        }
        return newSurvey;
    }
}