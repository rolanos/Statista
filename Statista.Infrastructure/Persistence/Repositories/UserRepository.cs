using Microsoft.EntityFrameworkCore;
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
        await _dbContext.AddAsync(user);

        await _dbContext.SaveChangesAsync();
    }

    public async Task<User?> DeleteUserById(Guid id)
    {
        var user = await GetUserById(id);
        if (user is not null)
        {
            _dbContext.Users.Remove(user);
            await _dbContext.SaveChangesAsync();
            return user;
        }
        return null;
    }

    public Task<User?> GetUserByEmail(string email)
    {
        return _dbContext.Users.SingleOrDefaultAsync(u => u.Email == email);
    }

    public Task<User?> GetUserById(Guid id)
    {
        return _dbContext.Users.SingleOrDefaultAsync(u => u.Id!.Equals(id));
    }

    public Task<User?> GetUserByUsername(string username)
    {
        return _dbContext.Users.SingleOrDefaultAsync(u => u.Username!.Equals(username));
    }

    public IReadOnlyCollection<User?> GetUsers()
    {
        return _dbContext.Users.ToList().AsReadOnly();
    }

    public async Task<User?> UpdateUser(User user)
    {
        var oldElement = await GetUserById(user.Id);
        if (oldElement is null)
        {
            throw new Exception("In DataBase no User with this Id");
        }

        _dbContext.Entry(oldElement).CurrentValues.SetValues(user);

        await _dbContext.SaveChangesAsync();

        return await GetUserById(user.Id);
    }
}