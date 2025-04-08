using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IFormRepository
{
    Task<Form?> CreateForm(Form form);
    Task<ICollection<Form>> GetAllForms(Guid SurveyId);
    Task<Form?> GetFormBySurveyId(Guid surveyId);
    Task<Form?> DeleteById(Guid id);
}