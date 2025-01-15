namespace Statista.Domain.Entities;

public class Report
{
    public Guid Id { get; set; }
    public Guid ReportTypeId { get; set; }
    public ReportType ReportType { get; set; }
    public Guid ReportedQuestionId { get; set; }
    public Question ReportedQuestion { get; set; }
    public string Message { get; set; }
    public Guid CreatedById { get; set; }
    public User CreatedBy { get; set; }
}