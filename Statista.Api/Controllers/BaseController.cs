using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Statista.Api.Controllers;

[ApiController]
public abstract class BaseController : ControllerBase
{
    private IMediator? _mediator;
    private IMapper? _mapper;

    protected IMediator mediator => (_mediator ??= HttpContext.RequestServices.GetService<IMediator>()) ?? throw new ArgumentException("DI error: no IMediator in BaseController");
    protected IMapper mapper => (_mapper ??= HttpContext.RequestServices.GetService<IMapper>()) ?? throw new ArgumentException("DI error: no IMapper in BaseController");
}