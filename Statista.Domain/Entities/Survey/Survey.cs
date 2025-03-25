using Statista.Domain.Entities;

public class Survey
{
    public Guid Id { get; set; }
    public Form form { get; set; }
    public List<Answer> answers { get; set; } = new();
}