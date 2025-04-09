using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.AvailableAnswers.Dto;
using Statista.Application.Features.Surveys.CreateSurvey;
using Statista.Application.Features.Surveys.Queries.GetSurveys;

namespace Statista.Api.Controllers;

[ApiController]
[Route("avaliable_answer")]
public class AvaliableAnswerController : BaseController
{
    [HttpPost]
    public async Task<IActionResult> CreateAvailableAnswer(CreateAvailableAnswerCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(mapper.Map<AvailableAnswerResponse>(result));
    }

    [HttpGet]
    public async Task<IActionResult> GetSectionsByFormId([FromQuery] GetAvailableAnswersByQuestionIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteById(DeleteAvailableAnswerByIdCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}