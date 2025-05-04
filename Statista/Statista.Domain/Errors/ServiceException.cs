namespace Statista.Domain.Errors;

public class ServiceException : Exception
{
    public int StatusCode { get; set; }
    public string ErrorMessage { get; set; } = string.Empty;

    public ServiceException(int statusCode, string errorMessage)
    {
        StatusCode = statusCode;
        ErrorMessage = errorMessage;
    }
}