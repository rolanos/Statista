
using FluentValidation;
using Statista.Application.Authentification.Commands.Register;

public class RegisterCommandValidator : AbstractValidator<RegisterCommand>
{
    public RegisterCommandValidator()
    {
        RuleFor(x => x.FirstName).MaximumLength(50).MinimumLength(1);
        RuleFor(x => x.LastName).MaximumLength(50).MinimumLength(1);
        RuleFor(x => x.Email).EmailAddress();
        RuleFor(x => x.Password).MinimumLength(6);
    }
}