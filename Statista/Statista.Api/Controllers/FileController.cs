using Microsoft.AspNetCore.Mvc;
using Statista.Api.Controllers;
using Statista.Application.Features.Files.Commands.CreateFile;
using Statista.Application.Features.Files.Queries.GetFilesFromElementId;

[ApiController]
[Route("files")]
public class FileController : BaseController
{
    [HttpGet()]
    public async Task<IActionResult> GetFilesByElementId(string name)
    {
        var path = Path.Combine(Path.Combine(Directory.GetCurrentDirectory(), "Uploads"), name);
        if (!System.IO.File.Exists(path))
            return NotFound();

        var bytes = await System.IO.File.ReadAllBytesAsync(path);
        return File(bytes, "image/jpeg");
    }


    [HttpGet("/element")]
    public async Task<IActionResult> GetFilesByElementId([FromQuery] GetFilesFromElementIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> UploadFile([FromForm] CreateFileCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }
}