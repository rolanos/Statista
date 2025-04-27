using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.AdminGroups.Commands.CreateAdminGroup;
using Statista.Application.Features.AdminGroups.Queries.GetAdminGroupBySyrveyId;
using Statista.Application.Features.SurveyConfigurations.Commands.UpdateSurveyConfiguration;

namespace Statista.Api.Controllers;

[ApiController]
[Route("admin_group")]
public class SurveyConfigurationController : BaseController
{
    [HttpPatch]
    public async Task<IActionResult> CreateAdminGroup(UpdateSurveyConfigurationCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}