using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Analitical.Dto;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class AnaliticalRepository : IAnaliticalRepository
{
    private readonly PostgresDbContext _dbContext;

    public AnaliticalRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<AnaliticalComplexResult> Analyse(AnaliticalParameters parameters)
    {
        Guid _;
        var complex = new AnaliticalComplexResult()
        {
            QuestionId = parameters.QuestionId,
        };
        complex.AnaliticalResults = await _dbContext.AnaliticalFacts
        .Where(f => f.QuestionId == parameters.QuestionId)
        .GroupBy(f => new { f.AnswerValue, f.AvailableAnswerId }) // Группируем по обоим полям
        .Select(g => new AnaliticalResult
        {
            AnswerId = g.Key.AvailableAnswerId,
            AnswerValue = g.Key.AnswerValue,
            Count = g.Count()
        })
        .ToListAsync();
        complex.TotalCount = complex.AnaliticalResults.Sum(r => r.Count);
        return complex;
    }
}