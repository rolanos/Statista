namespace Statista.Application.Features.ReportTypes.Dto;

public class CreateReportTypeRequest
{
    public string Name { get; set; }
    public bool Critical { get; set; }
}

public class UpdateReportTypeRequest
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public bool Critical { get; set; }
}