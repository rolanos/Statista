using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Answers.Commands.CreateAnswersToForm;

public class CreateAnswersToFormCommandHandler : IRequestHandler<CreateAnswersToFormCommand, Guid>
{
    private readonly IAnswerRepository _answerRepository;

    private readonly IQuestionRepository _questionRepository;

    private readonly IFormRepository _formRepository;

    public CreateAnswersToFormCommandHandler(IAnswerRepository answerRepository,
                                             IQuestionRepository questionRepository,
                                             IFormRepository formRepository)
    {
        _answerRepository = answerRepository;
        _questionRepository = questionRepository;
        _formRepository = formRepository;
    }

    public async Task<Guid> Handle(CreateAnswersToFormCommand request, CancellationToken cancellationToken)
    {
        foreach (var answerDto in request.answers)
        {
            //TODO проверки
            var answer = new Answer
            {
                Id = Guid.NewGuid(),
                QuestionId = answerDto.QuestionId,
                AnswerValueId = answerDto.AnswerValueId,
            };
            var newAnswer = await _answerRepository.CreateAnswer(answer);
            if (newAnswer is null)
            {
                throw new Exception("Answer have not created");
            }
        }

        return request.FormId;
    }
}