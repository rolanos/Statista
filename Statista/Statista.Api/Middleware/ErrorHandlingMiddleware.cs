using System.Net;
using System.Text.Json;
using Statista.Domain.Errors;

public class ErrorHandlingMiddleware
{
    private readonly RequestDelegate _next;

    private readonly ILogger<ErrorHandlingMiddleware> _logger;
    public ErrorHandlingMiddleware(RequestDelegate next, ILogger<ErrorHandlingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task Invoke(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError("Exception: {ex}", ex.Message);
            //Перехватываем и обрабатываем исключение
            await HandleExceptionAsync(context, ex);
        }
    }

    private static Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        var code = HttpStatusCode.InternalServerError;
        var result = JsonSerializer.Serialize(new { error = exception.Message, status = code });
        context.Response.ContentType = "application/json";
        context.Response.StatusCode = (int)code;
        switch (exception)
        {
            case ServiceException serviceException:
                return context.Response.WriteAsync(JsonSerializer.Serialize(new { error = serviceException.ErrorMessage, status = serviceException.StatusCode }));
            case Exception:
                return context.Response.WriteAsync(result);
        }
        return context.Response.WriteAsync(result);
    }
}