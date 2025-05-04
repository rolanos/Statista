namespace Statista.Application.Common.Interfaces.Persistence;

public interface IFileRepository
{
    Task<Domain.Entities.File?> CreateFile(Domain.Entities.File file);
    Task<ICollection<Domain.Entities.File>> GetFilesByElementId(Guid elementId);
    Task<Domain.Entities.File?> DeleteFile(Domain.Entities.File file);
}