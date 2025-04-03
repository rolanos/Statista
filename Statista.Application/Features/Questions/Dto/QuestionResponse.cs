using Statista.Domain.Entities;

namespace Statista.Application.Features.Questions.Dto;

public class QuestionResponse
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public Guid? TypeId { get; set; }
    public Guid FormId { get; set; }
    public Guid SectionId { get; set; }
    public Guid CreatedById { get; set; }
    public ICollection<AvailableAnswer> availableAnswers { get; set; } = new List<AvailableAnswer>();
    public DateTime CreatedDate { get; set; }
}