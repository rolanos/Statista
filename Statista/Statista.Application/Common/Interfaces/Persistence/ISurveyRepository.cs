using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface ISurveyRepository
{
    Task<Survey?> CreateSurvey(Survey survey);
    Task<ICollection<Survey>> GetAllSurveys();
    Task<Survey?> DeleteById(Guid id);
}