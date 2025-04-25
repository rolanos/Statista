using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateAnswerCommandHandler : IRequestHandler<CreateAnswerCommand, Answer>
{
    private readonly IAnswerRepository _answerRepository;

    public CreateAnswerCommandHandler(IAnswerRepository answerRepository)
    {
        _answerRepository = answerRepository;
    }

    public async Task<Answer> Handle(CreateAnswerCommand request, CancellationToken cancellationToken)
    {
        var answer = new Answer
        {
            Id = Guid.NewGuid(),
            QuestionId = request.QuestionId,
            AnswerValueId = request.AnswerValueId,
            RespondentId = request.UserId,
        };
        var newAnswer = await _answerRepository.CreateAnswer(answer);
        if (newAnswer is null)
        {
            throw new Exception("Answer have not created");
        }
        return newAnswer;
    }
}