using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;
using Statista.Infrastructure.Persistence;

public class UserRepository : IUserRepository
{
    private readonly PostgresDbContext _dbContext;

    public UserRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }
    public async Task Add(User user)
    {
        _dbContext.Add(user);

        await _dbContext.SaveChangesAsync();
    }

    public async Task<bool> DeleteUserById(Guid id)
    {
        var user = GetUserById(id);
        if (user is not null)
        {
            var deleted = _dbContext.Users.Remove(user);
            await _dbContext.SaveChangesAsync();
            return true;
        }
        return false;
    }

    public User? GetUserByEmail(string email)
    {
        return _dbContext.Users.SingleOrDefault(u => u.Email == email);
    }

    public User? GetUserById(Guid id)
    {
        return _dbContext.Users.SingleOrDefault(u => u.Id!.Equals(id));
    }

    public IReadOnlyCollection<User?> GetUsers()
    {
        return _dbContext.Users.ToList().AsReadOnly();
    }

    public async Task<User?> UpdateUser(User user)
    {
        _dbContext.Users.Update(user);
        await _dbContext.SaveChangesAsync();
        return GetUserById(user.Id);
    }
}