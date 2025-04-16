using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class AvailableAnswerRepository : IAvailableAnswerRepository
{
    private readonly PostgresDbContext _dbContext;

    public AvailableAnswerRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<AvailableAnswer?> CreateAvailableAnswer(AvailableAnswer availableAnswer)
    {
        await _dbContext.AddAsync(availableAnswer);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.AvailableAnswers.SingleOrDefaultAsync(u => u.Id == availableAnswer.Id);
    }

    public async Task<AvailableAnswer?> DeleteById(Guid id)
    {
        var availableAnswer = await _dbContext.AvailableAnswers.AsNoTracking()
                                                               .SingleOrDefaultAsync(u => u.Id == id);
        if (availableAnswer is not null)
        {
            _dbContext.AvailableAnswers.Remove(availableAnswer);
            await _dbContext.SaveChangesAsync();
            return availableAnswer;
        }
        return null;
    }

    public async Task<AvailableAnswer?> GetAvailableAnswerById(Guid id)
    {
        return await _dbContext.AvailableAnswers.AsNoTracking()
                                                .SingleOrDefaultAsync(u => u.Id == id);
    }

    public async Task<ICollection<AvailableAnswer>> GetAvailableAnswersByQuestionId(Guid questionId)
    {
        return await _dbContext.AvailableAnswers.AsNoTracking()
                                                .Where(u => u.QuestionId == questionId)
                                                .ToListAsync();
    }

    public async Task<AvailableAnswer?> UpdateAvailableAnswer(AvailableAnswer availableAnswer)
    {
        _dbContext.Update(availableAnswer);

        await _dbContext.SaveChangesAsync();

        return await GetAvailableAnswerById(availableAnswer.Id);
    }
}