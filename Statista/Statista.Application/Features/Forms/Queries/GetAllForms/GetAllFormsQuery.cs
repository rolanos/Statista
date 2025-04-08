using MediatR;
using Statista.Application.Features.Forms.Dto;

namespace Statista.Application.Features.Forms.Queries.GetAllForms;

public record GetAllFormsQuery(Guid SurveyId) : IRequest<ICollection<FormResponse>>;