using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Sections.Command.DeleteSection;
using Statista.Application.Features.Sections.Dto;
using Statista.Application.Features.Surveys.CreateSurvey;
using Statista.Application.Features.Surveys.Queries.GetSurveys;

namespace Statista.Api.Controllers;

[ApiController]
[Route("sections")]
public class SectionController : BaseController
{
    [HttpPost]
    public async Task<IActionResult> CreateSections(CreateSectionCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(mapper.Map<SectionResponse>(result));
    }

    [HttpGet]
    public async Task<IActionResult> GetSectionsByFormId([FromQuery] GetSectionsByFormIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteSection(DeleteSectionCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}