using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IQuestionRepository
{
    Task<Question?> Add(Question question);
    Task<ICollection<Question>> GetQuestions();
    Task<Question?> GetQuestionById(Guid id);
}