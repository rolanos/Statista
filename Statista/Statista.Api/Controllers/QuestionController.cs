using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Forms.Commands.CreateForm;
using Statista.Application.Features.Questions.Dto;
using Statista.Application.Features.Questions.Queries.GetQuestionsBySectionId;

namespace Statista.Api.Controllers;

[ApiController]
[Route("questions")]
public class QuestionController : BaseController
{
    [HttpPost]
    public async Task<IActionResult> CreateQuestion(CreateQuestionCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(mapper.Map<QuestionResponse>(result));
    }

    [HttpGet]
    public async Task<IActionResult> GetQuestionsBySectionId([FromQuery] GetQuestionsBySectionIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteById(DeleteFormByIdCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(mapper.Map<QuestionResponse>(result));
    }
}