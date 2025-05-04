using MediatR;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Authentification.Commands.Register;
using Statista.Application.Authentification.Queries.Login;

namespace Statista.Api.Controllers;

[ApiController]
[Route("auth")]
public class AuthenticationController : ControllerBase
{
    private readonly IMediator _mediator;

    public AuthenticationController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register(RegisterCommand request)
    {

        var authResult = await _mediator.Send(request);

        return Ok(authResult.User);
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login(LoginQuery request)
    {
        var authResult = await _mediator.Send(request);

        HttpContext.Response.Headers.Append("Authorization", "Bearer " + authResult.Token);

        return Ok(authResult.User);
    }
}