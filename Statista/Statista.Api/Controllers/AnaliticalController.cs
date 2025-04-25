using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Forms.Queries.GetAllForms;

namespace Statista.Api.Controllers;

[ApiController]
[Route("analitical")]
public class AnaliticalController : BaseController
{
    [HttpGet]
    public async Task<IActionResult> CreateAnswer([FromQuery] GetAnaliticDataByQuestionQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}