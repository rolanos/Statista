namespace Statista.Domain.Entities;

public class Section
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public ICollection<Section> sections { get; set; }
    public ICollection<Question> questions { get; set; }
    public int? order { get; set; }
}