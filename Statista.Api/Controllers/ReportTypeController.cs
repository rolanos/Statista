using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.ReportTypes.Dto;
using Statista.Application.Features.ReportTypes.Commands.CreateReportType;
using Statista.Application.Features.ReportTypes.Commands.UpdateReportType;
using Statista.Application.Features.ReportTypes.Query.GetReportTypes;
using Statista.Application.Features.ReportTypes.Query.GetReportTypesById;
using Microsoft.AspNetCore.Authorization;
using Statista.Domain.Constants;

namespace Statista.Api.Controllers;

[ApiController]
[Route("report_types")]
public class ReportTypeController : BaseController
{
    [HttpGet()]
    [Authorize(Permissions.Read)]
    public async Task<IActionResult> GetReportTypes()
    {
        var result = await mediator.Send(new GetReportTypesQuery());
        return Ok(result);
    }

    [HttpGet("{id:guid}")]
    public async Task<IActionResult> GetReportTypeById(Guid id)
    {
        var result = await mediator.Send(new GetReportTypeByIdQuery(id));
        return Ok(result);
    }

    [HttpPost()]
    public async Task<IActionResult> CreateReportType(CreateReportTypeRequest request)
    {
        var command = mapper.Map<CreateReportTypeCommand>(request);
        var result = await mediator.Send(command);
        return Ok(result);
    }

    [HttpPut()]
    public async Task<IActionResult> UpdateReportType(UpdateReportTypeRequest request)
    {
        var command = mapper.Map<UpdateReportTypeCommand>(request);
        var result = await mediator.Send(command);
        return Ok(result);
    }
}