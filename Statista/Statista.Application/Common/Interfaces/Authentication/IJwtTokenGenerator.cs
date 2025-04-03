public interface IJwtTokenGenerator
{
    string GenerateToken(Guid userId);
}