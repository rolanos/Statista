using Statista.Application.Features.AvailableAnswers.Dto;

namespace Statista.Application.Features.Questions.Dto;

public class QuestionResponse
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public Guid? TypeId { get; set; }
    public Guid FormId { get; set; }
    public Guid? pastQuestionId { get; set; }
    public Guid? nextQuestionId { get; set; }
    public Guid SectionId { get; set; }
    public DateTime CreatedDate { get; set; }
    public ICollection<AvailableAnswerResponse> AvailableAnswers { get; set; } = new List<AvailableAnswerResponse>();
}