using MediatR;
using Statista.Application.Features.Analitical.Dto;

namespace Statista.Application.Features.Forms.Queries.GetAllForms;

public record GetAnaliticDataByQuestionQuery(Guid QuestionId, AnaliticRequest? AnaliticRequest) : IRequest<AnaliticComplexResponse>;