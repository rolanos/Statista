namespace Statista.Domain.Entities;

public class UserInfo
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public User User { get; set; }
    public bool? IsMan { get; set; }
    public DateTime? Birthday { get; set; }
}