public class UserRepository : IUserRepository
{
    private static readonly List<UserEntity> _users = new();
    public void Add(UserEntity user)
    {
        _users.Add(user);
    }

    public UserEntity? GetUserByEmail(string email)
    {
        return _users.SingleOrDefault(u => u.Email == email);
    }
}