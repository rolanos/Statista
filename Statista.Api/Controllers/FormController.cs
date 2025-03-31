using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Forms.Commands.CreateForm;
using Statista.Application.Features.Forms.Dto;
using Statista.Application.Features.Forms.Queries.GetAllForms;

namespace Statista.Api.Controllers;

[ApiController]
[Route("forms")]
public class FormController : BaseController
{
    [HttpGet]
    public async Task<IActionResult> GetAllForms()
    {
        var result = await mediator.Send(new GetAllFormsQuery());
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> CreateForm(CreateFormCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(mapper.Map<FormResponse>(result));
    }
}