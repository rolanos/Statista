using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Surveys.CreateSurvey;
using Statista.Application.Features.Surveys.Dto;
using Statista.Application.Features.Surveys.Queries.GetSurveys;

namespace Statista.Api.Controllers;

[ApiController]
[Route("surveys")]
public class SurveyController : BaseController
{
    [HttpGet]
    public async Task<IActionResult> GetSurveys()
    {
        var result = await mediator.Send(new GetSurveysQuery());
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> CreateSurvey(CreateSurveyCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(mapper.Map<SurveyResponse>(result));
    }
}