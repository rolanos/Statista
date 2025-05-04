namespace Statista.Domain.Entities;

public class File
{
    public Guid Id { get; set; }
    public string FullName { get; set; } = string.Empty;
    public long Size { get; set; }
    public Guid ElementId { get; set; }
    public DateTime CreatedDate { get; set; }
}