using Statista.Domain.Entities;

public class Answer
{
    public Guid Id { get; set; }
    public Guid RespondentId { get; set; }
    public User Respondent { get; set; }
    public Guid AnswerId { get; set; }
    public EnumPosition AnswerValue { get; set; }
}