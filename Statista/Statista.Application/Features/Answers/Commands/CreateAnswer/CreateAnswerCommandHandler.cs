using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateAnswerCommandHandler : IRequestHandler<CreateAnswerCommand, Answer>
{
    private readonly IAnswerRepository _answerRepository;

    private readonly IAvailableAnswerRepository _availableAnswerRepository;

    public CreateAnswerCommandHandler(IAnswerRepository answerRepository,
                                      IAvailableAnswerRepository availableAnswerRepository)
    {
        _answerRepository = answerRepository;
        _availableAnswerRepository = availableAnswerRepository;
    }

    public async Task<Answer> Handle(CreateAnswerCommand request, CancellationToken cancellationToken)
    {
        var answerMeaningValue = await _availableAnswerRepository.GetAvailableAnswerById(request.AnswerValueId);
        var answer = new Answer
        {
            Id = Guid.NewGuid(),
            QuestionId = request.QuestionId,
            AnswerValueId = request.AnswerValueId,
            RespondentId = request.UserId,
            AnswerMeaning = answerMeaningValue?.Text ?? string.Empty,
        };
        var newAnswer = await _answerRepository.CreateAnswer(answer);
        if (newAnswer is null)
        {
            throw new Exception("Answer have not created");
        }
        return newAnswer;
    }
}