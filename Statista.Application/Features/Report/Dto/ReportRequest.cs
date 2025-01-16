using Statista.Domain.Entities;

namespace Statista.Application.Features;

public class CreateReportRequest
{
    public Guid ReportTypeId { get; set; }
    public string Message { get; set; }
    public Guid CreatedById { get; set; }
}

public class UpdateReportRequest
{
    public Guid Id { get; set; }
    public Guid ReportTypeId { get; set; }
    public string Message { get; set; }
    public Guid CreatedById { get; set; }
}