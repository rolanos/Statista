
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.UserInfos.Commands.UpdateUserInfo;

namespace Statista.Api.Controllers;

[ApiController]
[Route("user_info")]
public class UserInfoController : BaseController
{
    [HttpPut]
    public async Task<IActionResult> UpdateUserInfo(UpdateUserInfoCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}