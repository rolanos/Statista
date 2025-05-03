using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class QuestionRepository : IQuestionRepository
{
    private readonly PostgresDbContext _dbContext;

    public QuestionRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Question?> CreateQuestion(Question question)
    {
        if (question.IsGeneral && question.SectionId is not null)
        {
            var ordered = await GetOrderedQuestionsOptimizedAsync(question.SectionId.GetValueOrDefault());

            if (ordered.Any())
            {
                question.PastQuestionId = ordered.Last().Id;
            }
        }

        await _dbContext.AddAsync(question);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.Questions.SingleOrDefaultAsync(u => u.Id == question.Id);
    }

    public async Task<ICollection<Question>> GetQuestionsBySectionId(Guid sectionId)
    {
        return await GetOrderedQuestionsOptimizedAsync(sectionId);
    }

    public async Task<Question?> DeleteById(Guid id)
    {
        var question = await _dbContext.Questions.AsNoTracking()
                                              .SingleOrDefaultAsync(u => u.Id == id);
        if (question is not null)
        {
            _dbContext.Questions.Remove(question);
            await _dbContext.SaveChangesAsync();
            return question;
        }
        return null;
    }

    public async Task<Question?> GetQuestionsById(Guid id)
    {
        return await _dbContext.Questions.AsNoTracking()
                                         .SingleOrDefaultAsync(u => u.Id == id);
    }

    public async Task<Question?> UpdateQuestion(Question question)
    {
        _dbContext.Questions.Update(question);

        await _dbContext.SaveChangesAsync();

        return await GetQuestionsById(question.Id);
    }

    public async Task<Question?> GetGeneralQuestion()
    {
        var list = await _dbContext.Questions.AsNoTracking()
                                             .Include(q => q.AvailableAnswers)
                                             .Where(q => q.IsGeneral)
                                             .ToListAsync();
        if (list.Count != 0)
        {
            return list[Random.Shared.Next(list.Count)];
        }
        return null;
    }

    private async Task<List<Question>> GetOrderedQuestionsOptimizedAsync(Guid sectionId)
    {
        var questions = await _dbContext.Questions.AsNoTracking()
                                                  .Where(q => q.SectionId == sectionId)
                                                  .ToListAsync();

        // Создаем словарь для быстрого поиска по Id
        var questionDict = questions.ToDictionary(q => q.Id);

        var orderedQuestions = new List<Question>();
        // Находим начало цепочки (вопрос без предыдущего)
        var current = questions.FirstOrDefault(q => q.PastQuestionId == null);

        while (current != null)
        {
            orderedQuestions.Add(current);
            current = questions.SingleOrDefault(q => q.PastQuestionId == current.Id);
        }

        return orderedQuestions;
    }
}