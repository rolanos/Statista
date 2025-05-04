using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateAnswerCommandHandler : IRequestHandler<CreateAnswerCommand, ICollection<Answer>>
{
    private readonly IAnswerRepository _answerRepository;

    private readonly IAvailableAnswerRepository _availableAnswerRepository;

    public CreateAnswerCommandHandler(IAnswerRepository answerRepository,
                                      IAvailableAnswerRepository availableAnswerRepository)
    {
        _answerRepository = answerRepository;
        _availableAnswerRepository = availableAnswerRepository;
    }

    public async Task<ICollection<Answer>> Handle(CreateAnswerCommand request, CancellationToken cancellationToken)
    {

        var answers = new List<Answer>();
        foreach (var item in request.AnswerValueIds)
        {
            var answerMeaningValue = await _availableAnswerRepository.GetAvailableAnswerById(item);
            if (answerMeaningValue is null)
            {
                throw new NotFoundException("Available answer not found");
            }
            var answer = new Answer
            {
                Id = Guid.NewGuid(),
                QuestionId = request.QuestionId,
                AnswerValueId = item,
                RespondentId = request.UserId,
                AnswerMeaning = answerMeaningValue?.Text ?? string.Empty,
            };
            answers.Add(answer);
            var newAnswer = await _answerRepository.CreateAnswer(answer);
            if (newAnswer is null)
            {
                throw new Exception("Answer have not created");
            }
        }
        return answers;
    }
}