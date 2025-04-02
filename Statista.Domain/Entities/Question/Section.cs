namespace Statista.Domain.Entities;

public class Section
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public Guid FormId { get; set; }
    public Form Form { get; set; }
    public Guid? ParentSection;
    public Section? ParentSecton { get; set; }
    public ICollection<Section> childrenSections { get; set; } = new List<Section>();
    public ICollection<Question> questions { get; set; }
    public int? order { get; set; }
}