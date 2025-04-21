using Statista.Domain.Entities;

namespace Statista.Application.Features.Analitical.Dto;

public class AnaliticalResult
{
    public Guid? AnswerId { get; set; }
    public AvailableAnswer? AvailableAnswer { get; set; }
    public string? AnswerValue { get; set; }
    public int Count { get; set; }
}