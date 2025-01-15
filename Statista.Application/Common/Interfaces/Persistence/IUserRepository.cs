using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IUserRepository
{
    Task<User?> GetUserById(Guid id);
    Task<User?> GetUserByEmail(string email);
    Task<User?> GetUserByUsername(string username);
    Task<User?> UpdateUser(User user);
    Task<User?> DeleteUserById(Guid id);
    IReadOnlyCollection<User?> GetUsers();
    Task Add(User user);
}