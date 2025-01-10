namespace Statista.Domain.Entities;

public class User : Entity<Guid>
{
    public User(
        Guid id,
        string username,
        string? name,
        string? surname,
        string email,
        DateTime createdDate,
        DateTime updatedDate) : base(id)
    {
        Id = id;
        Username = username;
        Name = name;
        Surname = surname;
        Email = email;
        CreatedDate = createdDate;
        UpdatedDate = updatedDate;
    }
    public string Username { get; set; }
    public string? Name { get; set; }
    public string? Surname { get; set; }
    public string Email { get; set; }
    public string? PasswordHash { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime UpdatedDate { get; set; }
}