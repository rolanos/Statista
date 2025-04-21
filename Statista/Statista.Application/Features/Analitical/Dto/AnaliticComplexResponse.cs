namespace Statista.Application.Features.Analitical.Dto;

public class AnaliticalComplexResponse
{
    public int TotalCount { get; set; } = 0;
    public ICollection<AnaliticalResponse> Data { get; set; } = new List<AnaliticalResponse>();
}