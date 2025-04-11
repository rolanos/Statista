using Statista.Domain.Entities;

public class Survey
{
    public Guid Id { get; set; }
    public Guid FormId { get; set; }
    public Form Form { get; set; }
    public List<Answer> answers { get; set; } = new();
    public Guid CreatedById { get; set; }
    public User CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
}