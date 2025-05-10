using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Infrastructure.Persistence.Repositories;

public class FileRepository : IFileRepository
{
    private readonly PostgresDbContext _dbContext;

    public FileRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Domain.Entities.File?> CreateFile(Domain.Entities.File file)
    {
        await _dbContext.AddAsync(file);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.Files.FirstOrDefaultAsync(u => u.Id == file.Id);
    }

    public async Task<Domain.Entities.File?> DeleteFile(Domain.Entities.File file)
    {
        var fileForDelete = await _dbContext.Files.AsNoTracking()
                                              .FirstOrDefaultAsync(f => f.Id == file.Id);
        if (fileForDelete is not null)
        {
            _dbContext.Files.Remove(fileForDelete);
            await _dbContext.SaveChangesAsync();
            return fileForDelete;
        }
        return null;
    }

    public async Task<ICollection<Domain.Entities.File>> GetFilesByElementId(Guid elementId)
    {
        return await _dbContext.Files.AsNoTracking()
                                         .Where(f => f.ElementId == elementId)
                                         .ToListAsync();
    }
}