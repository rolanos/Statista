using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Analitical.Dto;
using Statista.Application.Features.Forms.Queries.GetAllForms;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Analitical.Queries.GetAnaliticDataByQuestion;

public class GetAnaliticDataByQuestionQueryHandler : IRequestHandler<GetAnaliticDataByQuestionQuery, AnaliticalComplexResponse>
{
    private readonly IAnaliticalRepository _analiticalRepository;

    private readonly IMapper _mapper;

    public GetAnaliticDataByQuestionQueryHandler(IAnaliticalRepository analiticalRepository, IMapper mapper)
    {
        _analiticalRepository = analiticalRepository;
        _mapper = mapper;
    }

    public async Task<AnaliticalComplexResponse> Handle(GetAnaliticDataByQuestionQuery request, CancellationToken cancellationToken)
    {
        var parameters = new AnaliticalParameters
        {
            QuestionId = request.QuestionId,
        };
        var result = await _analiticalRepository.Analyse(parameters);
        var analiticResult = new AnaliticalComplexResponse()
        {
            QuestionId = request.QuestionId,
        };
        if (result != null)
        {
            analiticResult.TotalCount = result.TotalCount;
            foreach (var item in result.AnaliticalResults)
            {
                var response = new AnaliticalResponse()
                {
                    AnswerId = item.AnswerId,
                    AnswerValue = item.AnswerValue,
                    Count = item.Count,
                };
                analiticResult.Data.Add(response);
            }
        }
        else
        {
            throw new Exception("Analitic error");
        }

        return analiticResult;
    }
}