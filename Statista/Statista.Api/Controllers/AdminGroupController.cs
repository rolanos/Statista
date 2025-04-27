using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.AdminGroups.Queries.GetAdminGroupBySyrveyId;

namespace Statista.Api.Controllers;

[ApiController]
[Route("admin_group")]
public class AdminGroupController : BaseController
{
    [HttpGet]
    public async Task<IActionResult> GetAdminGroupBySyrveyId([FromQuery] GetAdminGroupBySurveyIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}