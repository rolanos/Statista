using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Constants;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateFormCommandHandler : IRequestHandler<CreateFormCommand, Form>
{
    private readonly ISurveyRepository _surveyRepository;
    private readonly ISurveyConfigurationRepository _surveyConfigurationRepository;
    private readonly IFormRepository _formRepository;
    private readonly ISectionRepository _sectionRepository;
    private readonly IAdminGroupRepository _adminGroupRepository;

    public CreateFormCommandHandler(ISurveyRepository surveyRepository,
                                    ISurveyConfigurationRepository surveyConfigurationRepository,
                                    IFormRepository formRepository,
                                    ISectionRepository sectionRepository,
                                    IAdminGroupRepository adminGroupRepository)
    {
        _surveyRepository = surveyRepository;
        _surveyConfigurationRepository = surveyConfigurationRepository;
        _formRepository = formRepository;
        _sectionRepository = sectionRepository;
        _adminGroupRepository = adminGroupRepository;
    }

    public async Task<Form> Handle(CreateFormCommand request, CancellationToken cancellationToken)
    {
        var surveyId = Guid.NewGuid();
        var formId = Guid.NewGuid();
        var adminGroup = new AdminGroup
        {
            SurveyId = surveyId,
            UserId = request.CreatedById,
            RoleId = RoleTypeConstants.SurveyAdmin.Id,
        };
        var survey = new Survey
        {
            Id = surveyId,
            FormId = formId,
            AdminGroup = [adminGroup],
            CreatedDate = DateTime.UtcNow,
        };
        var surveyConfiguration = new SurveyConfiguration
        {
            Id = Guid.NewGuid(),
            IsAnonymous = false,
            SurveyId = surveyId,
        };
        var form = new Form
        {
            Id = formId,
            Name = request.Name,
            Description = request.Description,
            CreatedDate = DateTime.UtcNow,
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

        var newSurveyConfiguration = await _surveyConfigurationRepository.CreateSurveyConfiguration(surveyConfiguration);

        if (newSurveyConfiguration is null)
        {
            throw new Exception("Survey configuration have not created");
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