using Statista.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Infrastructure.Persistence.Repositories;

public class SectionRepository : ISectionRepository
{
    private readonly PostgresDbContext _dbContext;

    public SectionRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Section?> CreateSection(Section section)
    {
        await _dbContext.AddAsync(section);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.Sections.SingleOrDefaultAsync(u => u.Id == section.Id);
    }

    public async Task<Section?> DeleteById(Guid id)
    {
        var section = await _dbContext.Sections.AsNoTracking()
                                               .SingleOrDefaultAsync(u => u.Id == id);
        if (section is not null)
        {
            _dbContext.Sections.Remove(section);
            await _dbContext.SaveChangesAsync();
            return section;
        }
        return null;
    }

    public async Task<ICollection<Section>> GetSectionsByFormId(Guid formId)
    {
        return await _dbContext.Sections.AsNoTracking()
                                        .Where(u => u.FormId == formId).ToListAsync();
    }
}