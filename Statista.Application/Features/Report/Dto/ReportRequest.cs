using Statista.Domain.Entities;

namespace Statista.Application.Features;

public class ReportRequest
{
    public Guid Id { get; set; }
    public Guid ReportTypeId { get; set; }
    public string Message { get; set; }
    public Guid CreatedById { get; set; }
}