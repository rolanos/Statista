namespace Statista.Application.Features.Analitical.Dto;

public class AnaliticComplexResponse
{
    public ICollection<AnaliticResponse> Data { get; set; } = new List<AnaliticResponse>();
}