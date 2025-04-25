using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IQuestionRepository
{
    Task<Question?> CreateQuestion(Question question);
    Task<ICollection<Question>> GetQuestionsBySectionId(Guid sectionId);
    Task<Question?> GetGeneralQuestion();
    Task<Question?> GetQuestionsById(Guid id);
    Task<Question?> UpdateQuestion(Question question);
    Task<Question?> DeleteById(Guid id);
}