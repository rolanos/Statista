using Microsoft.AspNetCore.Mvc;
using Statista.Application.Users.CreateUser;
using Statista.Application.Users.Dto;
using Statista.Application.Users.Queries.GetUserByEmail;
using Statista.Application.Users.Queries.GetUserById;
using Statista.Application.Users.Queries.GetUsers;

namespace Statista.Api.Controllers;

[ApiController]
[Route("api/users")]
public class UserController : BaseController
{
    [HttpGet]
    public async Task<IActionResult> GetUsers()
    {
        var createUserResult = await mediator.Send(new GetUsersQuery());
        logger.LogInformation("GetUsers success");
        return Ok(createUserResult);
    }

    [HttpGet("{id:guid}")]
    public async Task<IActionResult> GetUserById(Guid id)
    {
        var createUserResult = await mediator.Send(new GetUserByIdQuery(id));
        return Ok(createUserResult);
    }

    // [HttpGet("{email:alpha}")]
    // public async Task<IActionResult> GetUserByEmail(string email)
    // {
    //     var createUserResult = await mediator.Send(new GetUserByEmailQuery(email));
    //     return Ok(createUserResult);
    // }

    [HttpPost]
    public async Task<IActionResult> CreateUser(CreateUserRequest request)
    {
        var command = mapper.Map<CreateUserCommand>(request);
        var createUserResult = await mediator.Send(command);
        return Ok(mapper.Map<UserResponse>(createUserResult));
    }

    [HttpDelete("{id:guid}")]
    public async Task<IActionResult> DeleteUser(Guid id)
    {
        var createUserResult = await mediator.Send(new DeleteUserCommand(id));
        return Ok(createUserResult);
    }

    [HttpPut()]
    public async Task<IActionResult> UpdateUser(UpdateUserRequest request)
    {
        var command = mapper.Map<UpdateUserCommand>(request);
        var updateUserResult = await mediator.Send(command);
        return Ok(mapper.Map<UserResponse>(updateUserResult));
    }
}