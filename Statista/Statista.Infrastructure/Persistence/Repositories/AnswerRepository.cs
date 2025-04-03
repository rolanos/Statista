using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Infrastructure.Persistence.Repositories;

public class AnswerRepository : IAnswerRepository
{
    private readonly PostgresDbContext _dbContext;

    public AnswerRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Answer?> CreateAnswer(Answer answer)
    {
        await _dbContext.AddAsync(answer);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.Answers.SingleOrDefaultAsync(u => u.Id == answer.Id);
    }

    public async Task<ICollection<Answer>> GetAnswersByQuestionId(Guid questionId)
    {
        return await _dbContext.Answers.AsNoTracking()
                                        .Where(u => u.QuestionId == questionId).ToListAsync();
    }

    public async Task<ICollection<Answer>> GetAnswersBySurveyId(Guid surveyId)
    {
        throw new NotImplementedException("In development");
    }
}