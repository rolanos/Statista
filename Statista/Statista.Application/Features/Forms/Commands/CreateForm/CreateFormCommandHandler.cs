using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateFormCommandHandler : IRequestHandler<CreateFormCommand, Form>
{
    private readonly IFormRepository _formRepository;

    private readonly ISectionRepository _sectionRepository;

    public CreateFormCommandHandler(IFormRepository formRepository, ISectionRepository sectionRepository)
    {
        _formRepository = formRepository;
        _sectionRepository = sectionRepository;
    }

    public async Task<Form> Handle(CreateFormCommand request, CancellationToken cancellationToken)
    {
        var formId = Guid.NewGuid();
        var survey = new Form
        {
            Id = formId,
            Name = request.Name,
            Description = request.Description,
            CreatedDate = DateTime.UtcNow,
            CreatedById = request.CreatedById,
            SurveyId = request.SurveyId,
        };
        var emptySection = new Section
        {
            Id = Guid.NewGuid(),
            Title = "Пустой заголовок",
            FormId = formId,
            order = 1,
        };

        var newSurvey = await _formRepository.CreateForm(survey);

        if (newSurvey is null)
        {
            throw new Exception("Form have not created");
        }

        var newEmptySection = await _sectionRepository.CreateSection(emptySection);
        if (newEmptySection is null)
        {
            throw new Exception("Section have not created");
        }

        return newSurvey;
    }
}