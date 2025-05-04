using System.Net;

namespace Statista.Domain.Errors;

public class NotFoundException : ServiceException
{
    public NotFoundException(string message) : base(statusCode: (int)HttpStatusCode.NotFound,
                                                    errorMessage: message)
    { }
}