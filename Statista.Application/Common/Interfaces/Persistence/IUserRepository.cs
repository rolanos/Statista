using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IUserRepository
{
    User? GetUserById(Guid id);
    User? GetUserByEmail(string email);
    Task<User?> UpdateUser(User user);
    Task<bool> DeleteUserById(Guid id);
    IReadOnlyCollection<User?> GetUsers();
    Task Add(User user);
}