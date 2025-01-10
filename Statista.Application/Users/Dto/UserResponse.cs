namespace Statista.Application.Users.Dto;

public class UserResponse
{
    public UserResponse(
        Guid id,
        string name,
        string surname,
        string username,
        string email,
        DateTime createdDate,
        DateTime updatedDate)
    {
        Id = id;
        Name = name;
        Surname = surname;
        Username = username;
        Email = email;
        CreatedDate = createdDate;
        UpdatedDate = updatedDate;
    }
    public Guid Id { get; set; }
    public string? Name { get; set; }
    public string? Surname { get; set; }
    public string Username { get; set; }
    public string Email { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime UpdatedDate { get; set; }
}