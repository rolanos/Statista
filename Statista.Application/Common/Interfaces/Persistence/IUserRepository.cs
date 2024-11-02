public interface IUserRepository
{
    UserEntity? GetUserByEmail(string email);
    void Add(UserEntity user);
}