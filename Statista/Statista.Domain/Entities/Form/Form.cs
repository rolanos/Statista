namespace Statista.Domain.Entities;

public class Form
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public Guid SurveyId { get; set; }
    public Survey Survey { get; set; }
    public Guid CreatedById { get; set; }
    public User CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public ICollection<Section> Sections { get; set; }
}