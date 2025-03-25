using Statista.Domain.Entities;

public class Permission
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public ICollection<User> Users { get; set; } = [];
}