namespace Statista.Application.Features.AvailableAnswers.Dto;

public class AvailableAnswerResponse
{
    public Guid Id { get; set; }
    public string? Text { get; set; }
    public string? imageLink { get; set; }
    public Guid QuestionId { get; set; }
}