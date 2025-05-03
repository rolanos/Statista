using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Answers.Commands.CreateAnswersToForm;

public class CreateAnswersToFormCommandHandler : IRequestHandler<CreateAnswersToFormCommand, Guid>
{
    private readonly IAnswerRepository _answerRepository;

    private readonly IQuestionRepository _questionRepository;

    private readonly IFormRepository _formRepository;

    private readonly IAvailableAnswerRepository _availableAnswerRepository;

    public CreateAnswersToFormCommandHandler(IAnswerRepository answerRepository,
                                             IQuestionRepository questionRepository,
                                             IFormRepository formRepository,
                                             IAvailableAnswerRepository availableAnswerRepository)
    {
        _answerRepository = answerRepository;
        _questionRepository = questionRepository;
        _formRepository = formRepository;
        _availableAnswerRepository = availableAnswerRepository;
    }

    public async Task<Guid> Handle(CreateAnswersToFormCommand request, CancellationToken cancellationToken)
    {
        foreach (var answerDto in request.answers)
        {
            var answerMeaningValue = await _availableAnswerRepository.GetAvailableAnswerById(answerDto.AnswerValueId);
            var answer = new Answer
            {
                Id = Guid.NewGuid(),
                QuestionId = answerDto.QuestionId,
                AnswerValueId = answerDto.AnswerValueId,
                AnswerMeaning = answerMeaningValue?.Text ?? string.Empty,
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