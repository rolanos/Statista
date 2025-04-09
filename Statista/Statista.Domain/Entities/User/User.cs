namespace Statista.Domain.Entities;

public class User
{
    public Guid Id { get; set; }
    public string Email { get; set; }
    public Guid UserInfoId { get; set; }
    public UserInfo UserInfo { get; set; }
    public string? PasswordHash { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime UpdatedDate { get; set; }
}