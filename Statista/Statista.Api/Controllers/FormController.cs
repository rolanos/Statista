using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Forms.Commands.CreateForm;
using Statista.Application.Features.Forms.Dto;
using Statista.Application.Features.Forms.Queries.GetAllForms;
using Statista.Application.Features.Forms.Queries.GetFormById;
using Statista.Application.Features.Forms.Queries.GetFormsByUserId;

namespace Statista.Api.Controllers;

[ApiController]
[Route("forms")]
public class FormController : BaseController
{
    [HttpGet]
    public async Task<IActionResult> GetAllForms([FromQuery] GetAllFormsQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpGet]
    [Route("formId")]
    public async Task<IActionResult> GetFormById([FromQuery] GetFormByIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpGet]
    [Route("userId")]
    public async Task<IActionResult> GetFormById([FromQuery] GetFormsByUserIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> CreateForm(CreateFormCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(mapper.Map<FormResponse>(result));
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteForm(DeleteFormByIdCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(mapper.Map<FormResponse>(result));
    }
}