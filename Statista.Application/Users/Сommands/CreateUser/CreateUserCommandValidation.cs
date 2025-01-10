
using FluentValidation;
using Statista.Application.Users.CreateUser;

public class CreateMenuValidation : AbstractValidator<CreateUserCommand>
{
    public CreateMenuValidation()
    {
        RuleFor(x => x.Email).MaximumLength(50).MinimumLength(1);
    }
}