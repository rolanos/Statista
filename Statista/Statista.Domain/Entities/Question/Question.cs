namespace Statista.Domain.Entities;

public class Question
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public Guid? TypeId { get; set; }
    public Classifier? Type { get; set; }
    public Guid? SectionId { get; set; }
    public Section? Section { get; set; }
    public Guid? PastQuestionId { get; set; }
    public Guid? NextQuestionId { get; set; }
    public ICollection<AvailableAnswer> AvailableAnswers { get; set; } = new List<AvailableAnswer>();
    public DateTime CreatedDate { get; set; }
}