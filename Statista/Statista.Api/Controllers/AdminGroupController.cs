using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.AdminGroups.Commands.CreateAdminGroup;
using Statista.Application.Features.AdminGroups.Commands.DeleteAdminGroup;
using Statista.Application.Features.AdminGroups.Commands.UpdateAdminGroup;
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

    [HttpPost]
    public async Task<IActionResult> CreateAdminGroup(CreateAdminGroupCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPatch]
    public async Task<IActionResult> UpdateAdminGroup(UpdateAdminGroupCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteAdminGroup(DeleteAdminGroupCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}