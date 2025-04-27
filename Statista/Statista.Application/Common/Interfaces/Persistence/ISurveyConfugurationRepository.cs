using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface ISurveyConfigurationRepository
{
    Task<SurveyConfiguration?> CreateSurveyConfiguration(SurveyConfiguration surveyConfiguration);
    Task<SurveyConfiguration?> GetSurveyConfigurationBySurveyId(Guid surveyId);
    Task<SurveyConfiguration?> DeleteById(Guid id);
}