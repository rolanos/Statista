using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class QuestionRepository : IQuestionRepository
{
    public Task<Question?> Add(Question question)
    {
        throw new NotImplementedException();
    }

    public Task<Question?> GetQuestionById(Guid id)
    {
        throw new NotImplementedException();
    }

    public Task<ICollection<Question>> GetQuestions()
    {
        throw new NotImplementedException();
    }
}