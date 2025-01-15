namespace Statista.Domain.Entities;

public class Question
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public long AnswersAmount { get; set; }
    public Guid CategoryId { get; set; }
    public QuestionCategory Category { get; set; }
    public Guid FormId { get; set; }
    public Form Form { get; set; }
    public Guid QuestionTypeId { get; set; }
    public QuestionType QuestionType { get; set; }
    public Guid CreatedById { get; set; }
    public User CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
}