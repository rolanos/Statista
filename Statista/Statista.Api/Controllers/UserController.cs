using Microsoft.AspNetCore.Mvc;
using Statista.Application.Users.CreateUser;
using Statista.Application.Users.Dto;
using Statista.Application.Users.Queries.GetUserById;
using Statista.Application.Users.Queries.GetUsers;

namespace Statista.Api.Controllers;

[ApiController]
[Route("users")]
public class UserController : BaseController
{
    [HttpGet("all")]
    public async Task<IActionResult> GetUsers()
    {
        var result = await mediator.Send(new GetUsersQuery());
        logger.LogInformation("GetUsers success");
        return Ok(result);
    }

    [HttpGet()]
    public async Task<IActionResult> GetUserById([FromQuery] Guid id)
    {
        var result = await mediator.Send(new GetUserByIdQuery(id));
        return Ok(result);
    }

    [HttpDelete()]
    public async Task<IActionResult> DeleteUser([FromQuery] Guid id)
    {
        var result = await mediator.Send(new DeleteUserCommand(id));
        return Ok(result);
    }

    [HttpPut()]
    public async Task<IActionResult> UpdateUser(UpdateUserRequest request)
    {
        var command = mapper.Map<UpdateUserCommand>(request);
        var result = await mediator.Send(command);
        return Ok(mapper.Map<UserResponse>(result));
    }
}