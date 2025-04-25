using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateQuestionCommandHandler : IRequestHandler<CreateQuestionCommand, Question>
{
    private readonly IQuestionRepository _questionRepository;

    public CreateQuestionCommandHandler(IQuestionRepository questionRepository)
    {
        _questionRepository = questionRepository;
    }

    public async Task<Question> Handle(CreateQuestionCommand request, CancellationToken cancellationToken)
    {
        var question = new Question
        {
            Id = Guid.NewGuid(),
            Title = request.Title,
            PastQuestionId = request.PastQuestion,
            NextQuestionId = request.NextQuestion,
            TypeId = request.TypeId,
            SectionId = request.SectionId,
            CreatedDate = DateTime.UtcNow,
            IsGeneral = request.isGeneral
        };
        var newQuestion = await _questionRepository.CreateQuestion(question);
        if (newQuestion is null)
        {
            throw new Exception("Question have not created");
        }
        return newQuestion;
    }
}