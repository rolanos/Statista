using Statista.Domain.Entities;

namespace Statista.Application.Features.Surveys.Dto;

public class SurveyResponse
{
    public Guid Id { get; set; }
    public Guid CreatedById { get; set; }
    public User CreatedBy { get; set; }
}