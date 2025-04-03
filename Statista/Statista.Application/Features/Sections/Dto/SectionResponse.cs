namespace Statista.Application.Features.Sections.Dto;

public class SectionResponse
{
    public Guid Id { get; set; }
    public string Title { get; set; } = "Пустой заголовок";
    public Guid FormId { get; set; }
    public int? order { get; set; }
}