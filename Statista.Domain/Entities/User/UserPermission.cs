namespace Statista.Domain.Entities;

public class UserPermission
{
    public Guid UserId { get; set; }
    public Guid PermissionId { get; set; }
}