namespace Statista.Domain.Entities;

public class ReportType
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public bool Critical { get; set; }
}