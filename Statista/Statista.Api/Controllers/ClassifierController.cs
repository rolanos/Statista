using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Classifiers.Queries.GetAllQuestionTypes;
using Statista.Application.Features.Classifiers.Queries.GetAllSurveyRoles;
using Statista.Application.Features.Classifiers.Queries.GetAllSurveyTypes;
using Statista.Application.Features.Forms.Commands.CreateForm;
using Statista.Application.Features.Forms.Dto;
using Statista.Application.Features.Forms.Queries.GetAllForms;
using Statista.Application.Features.Forms.Queries.GetFormById;
using Statista.Application.Features.Forms.Queries.GetFormsByUserId;

namespace Statista.Api.Controllers;

[ApiController]
[Route("classifiers")]
public class ClassifierController : BaseController
{
    [HttpGet("question_types")]
    public async Task<IActionResult> GetAllQuestionTypes([FromQuery] GetAllQuestionTypesQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpGet("survey_roles")]
    public async Task<IActionResult> GetAllSurveyRoles([FromQuery] GetAllSurveyRolesQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpGet("survey_types")]
    public async Task<IActionResult> GetAllSurveyTypes([FromQuery] GetAllSurveyTypesQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}