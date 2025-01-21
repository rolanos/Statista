using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features;
using Statista.Application.Features.Report.Commands.CreateReport;
using Statista.Application.Features.Report.Queries.GetReportById;
using Statista.Application.Features.Report.Queries.GetReports;
using Statista.Application.Features.Report.Queries.GetReportsByQuestionId;

namespace Statista.Api.Controllers;

[ApiController]
[Route("reports")]
public class ReportController : BaseController
{
    [HttpGet()]
    public async Task<IActionResult> GetReports()
    {
        var result = await mediator.Send(new GetReportsQuery());
        return Ok(result);
    }

    [HttpGet("{id:guid}")]
    public async Task<IActionResult> GetReportById(Guid id)
    {
        var result = await mediator.Send(new GetReportByIdQuery(id));
        return Ok(result);
    }

    [HttpGet("/question/{question_id:guid}")]
    public async Task<IActionResult> GetReportsByQuestionId(Guid questionId)
    {
        var result = await mediator.Send(new GetReportsByQuestionIdQuery(questionId));
        return Ok(result);
    }

    [HttpPost()]
    public async Task<IActionResult> CreateReport(CreateReportRequest request)
    {
        var command = mapper.Map<CreateReportCommand>(request);
        var result = await mediator.Send(command);
        return Ok(result);
    }
}