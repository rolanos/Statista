using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Infrastructure.Persistence.Repositories;

class ClassifierRepository : IClassifierRepository
{
    private readonly PostgresDbContext _dbContext;

    public ClassifierRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Classifier?> CreateClassifier(Classifier classifier)
    {
        var contains = await _dbContext.Classifiers.FirstOrDefaultAsync(c => c.Id == classifier.Id);
        if (contains == null)
        {
            await _dbContext.AddAsync(classifier);

            await _dbContext.SaveChangesAsync();

            return await _dbContext.Classifiers.FirstOrDefaultAsync(c => c.Id == classifier.Id);
        }
        return contains;
    }

    public async Task<ICollection<Classifier>> GetAllChildrenByParentId(Guid? parentId)
    {
        return await _dbContext.Classifiers.AsNoTracking()
                                        .Where(c => c.ParentId == parentId).ToListAsync();
    }

    public async Task<Classifier?> GetClassifierById(Guid id)
    {
        return await _dbContext.Classifiers.FirstOrDefaultAsync(c => c.Id == id);
    }

    public async Task<bool> HasData()
    {
        return await _dbContext.Classifiers.AnyAsync();
    }
}