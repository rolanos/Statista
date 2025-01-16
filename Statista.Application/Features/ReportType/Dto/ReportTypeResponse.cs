namespace Statista.Application.Features.ReportTypes.Dto;

public class ReportTypeResponse
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public bool Critical { get; set; }
}