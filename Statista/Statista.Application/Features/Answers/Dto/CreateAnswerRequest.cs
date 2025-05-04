namespace Statista.Application.Features.Answers.Dto;

public class CreateAnswerRequest
{
    public Guid QuestionId { get; set; }
    public Guid AnswerValueId { get; set; }
}