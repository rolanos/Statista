using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.AdminGroups.Commands.CreateAdminGroup;
using Statista.Application.Features.AdminGroups.Queries.GetAdminGroupBySyrveyId;
using Statista.Application.Features.SurveyConfigurations.Commands.UpdateSurveyConfiguration;
using Statista.Application.Features.SurveyConfigurations.Queries.GetSurveyConfiguration;

namespace Statista.Api.Controllers;

[ApiController]
[Route("survey_configuration")]
public class SurveyConfigurationController : BaseController
{

    [HttpGet]
    public async Task<IActionResult> GetSurveyConfigurationBySurveyId([FromQuery] GetSurveyConfigurationQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPatch]
    public async Task<IActionResult> CreateSurveyConfiguration(UpdateSurveyConfigurationCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}