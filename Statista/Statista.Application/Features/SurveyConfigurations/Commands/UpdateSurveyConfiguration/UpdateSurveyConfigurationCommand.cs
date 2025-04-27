using MediatR;
using Statista.Application.Features.SurveyConfigurations.Dto;

namespace Statista.Application.Features.SurveyConfigurations.Commands.UpdateSurveyConfiguration;

public record UpdateSurveyConfigurationCommand(Guid Id,
                                               DateTime? StartDate,
                                               DateTime? EndDate,
                                               bool? IsAnonymous) : IRequest<SurveyConfigurationResponse>;