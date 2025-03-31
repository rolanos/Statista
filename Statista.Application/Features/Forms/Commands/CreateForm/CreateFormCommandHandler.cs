using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateFormCommandHandler : IRequestHandler<CreateFormCommand, Form>
{
    private readonly IFormRepository _formRepository;

    public CreateFormCommandHandler(IFormRepository formRepository)
    {
        _formRepository = formRepository;
    }

    public async Task<Form> Handle(CreateFormCommand request, CancellationToken cancellationToken)
    {
        var survey = new Form
        {
            Id = Guid.NewGuid(),
            Name = request.Name,
            Description = request.Description,
            CreatedDate = DateTime.UtcNow,
            CreatedById = request.CreatedById,
            SurveyId = request.SurveyId,
        };
        var newSurvey = await _formRepository.CreateForm(survey);
        if (newSurvey is null)
        {
            throw new Exception("Form have not created");
        }
        return newSurvey;
    }
}