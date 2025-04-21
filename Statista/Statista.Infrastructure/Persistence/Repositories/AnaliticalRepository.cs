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
        var complex = new AnaliticalComplexResult();
        complex.AnaliticalResults = await _dbContext.AnaliticalFacts
            .Where(f => f.QuestionId == parameters.QuestionId)
            .GroupBy(f => f.AnswerValue)
            .Select(g => new AnaliticalResult
            {
                // Если AnswerValue соответствует ID варианта ответа (AvailableAnswer)
                AnswerId = Guid.TryParse(g.Key, out _) ? Guid.Parse(g.Key) : null,
                AnswerValue = g.Key,
                Count = g.Count()
            })
            .ToListAsync();
        complex.TotalCount = complex.AnaliticalResults.Sum(r => r.Count);
        return complex;
    }
}