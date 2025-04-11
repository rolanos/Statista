using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateFormCommandHandler : IRequestHandler<CreateFormCommand, Form>
{
    private readonly ISurveyRepository _surveyRepository;
    private readonly IFormRepository _formRepository;

    private readonly ISectionRepository _sectionRepository;

    public CreateFormCommandHandler(ISurveyRepository surveyRepository,
                                    IFormRepository formRepository,
                                    ISectionRepository sectionRepository)
    {
        _surveyRepository = surveyRepository;
        _formRepository = formRepository;
        _sectionRepository = sectionRepository;
    }

    public async Task<Form> Handle(CreateFormCommand request, CancellationToken cancellationToken)
    {
        var surveyId = Guid.NewGuid();
        var formId = Guid.NewGuid();
        var survey = new Survey
        {
            Id = surveyId,
            FormId = formId,
            CreatedById = request.CreatedById,
            CreatedDate = DateTime.UtcNow,
        };
        var form = new Form
        {
            Id = formId,
            Name = request.Name,
            Description = request.Description,
            CreatedDate = DateTime.UtcNow,
            CreatedById = request.CreatedById,
            SurveyId = surveyId,
        };
        var emptySection = new Section
        {
            Id = Guid.NewGuid(),
            Title = "Пустой заголовок",
            FormId = formId,
            Order = 1,
        };

        var newSurvey = await _surveyRepository.CreateSurvey(survey);

        if (newSurvey is null)
        {
            throw new Exception("Survey have not created");
        }

        var newform = await _formRepository.CreateForm(form);

        if (newform is null)
        {
            throw new Exception("Form have not created");
        }

        var newEmptySection = await _sectionRepository.CreateSection(emptySection);
        if (newEmptySection is null)
        {
            throw new Exception("Section have not created");
        }

        return newform;
    }
}