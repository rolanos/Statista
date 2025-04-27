using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.SurveyConfigurations.Dto;

namespace Statista.Application.Features.SurveyConfigurations.Commands.UpdateSurveyConfiguration;

public class UpdateSurveyConfigurationCommandHandler : IRequestHandler<UpdateSurveyConfigurationCommand, SurveyConfigurationResponse>
{
    private readonly ISurveyConfigurationRepository _surveyConfigurationRepository;

    private IMapper _mapper;
    public UpdateSurveyConfigurationCommandHandler(IMapper mapper, ISurveyConfigurationRepository surveyConfigurationRepository)
    {
        _mapper = mapper;
        _surveyConfigurationRepository = surveyConfigurationRepository;
    }

    public async Task<SurveyConfigurationResponse> Handle(UpdateSurveyConfigurationCommand request, CancellationToken cancellationToken)
    {
        var surveyConfiguration = await _surveyConfigurationRepository.GetSurveyConfigurationById(request.Id);
        if (surveyConfiguration is not null)
        {
            if (request.StartDate != null)
            {
                surveyConfiguration.StartDate = request.StartDate;
            }
            if (request.EndDate != null)
            {
                surveyConfiguration.EndDate = request.EndDate;
            }
            if (request.IsAnonymous != null)
            {
                surveyConfiguration.IsAnonymous = request.IsAnonymous ?? false;
            }

            var updatedConfiguration = await _surveyConfigurationRepository.Update(surveyConfiguration);

            if (updatedConfiguration is null)
            {
                throw new Exception("Survey configuration update error");
            }
            return _mapper.Map<SurveyConfigurationResponse>(updatedConfiguration);
        }
        else
        {
            throw new Exception("Survey configuration not founded");
        }
    }
}