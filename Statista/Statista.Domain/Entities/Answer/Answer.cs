using Statista.Domain.Entities;

public class Answer
{
    public Guid Id { get; set; }
    public Guid QuestionId { get; set; }
    public Question Question { get; set; }
    public Guid? AnswerValueId { get; set; }
    public AvailableAnswer? AnswerValue { get; set; }
    public Guid? RespondentId;
    public User? Respondent;
}