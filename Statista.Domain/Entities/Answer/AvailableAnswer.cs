namespace Statista.Domain.Entities;

public class AvailableAnswer
{
    public Guid Id { get; set; }
    public string? Text { get; set; }
    public string? imageLink { get; set; }
    public Guid QuestionId { get; set; }
    public Question Question { get; set; }
}