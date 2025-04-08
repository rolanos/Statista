namespace Statista.Application.Users.Dto;

public class UserResponse
{
    public Guid Id { get; set; }
    public string Email { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime UpdatedDate { get; set; }
}