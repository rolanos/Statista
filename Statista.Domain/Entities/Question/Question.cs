namespace Statista.Domain.Entities;

public class Question
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public Guid? TypeId { get; set; }
    public Classifier? Type { get; set; }
    public Guid FormId { get; set; }
    public Form Form { get; set; }
    public Guid CreatedById { get; set; }
    public User CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
}