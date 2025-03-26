using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface ISurveyRepository
{
    Task<Survey?> CreateEmpty(User createdBy);
    Task<ICollection<Survey>> GetByUserId(Guid userId);
    Task<Report?> DeleteById(Guid id);
}