namespace Statista.Application.Features.Files.Dto;

public class FileResponse
{
    public Guid Id { get; set; }
    public string FullName { get; set; } = string.Empty;
    public long Size { get; set; }
    public Guid ElementId { get; set; }
    public DateTime CreatedDate { get; set; }
}