
using MediatR;

namespace Statista.Application.Features.Surveys.CreateSurvey;

public record CreateSurveyCommand(Guid createdById) : IRequest<Survey>;