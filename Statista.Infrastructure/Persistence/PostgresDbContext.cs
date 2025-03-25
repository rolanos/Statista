using Microsoft.EntityFrameworkCore;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence;

public class PostgresDbContext : DbContext
{
    public PostgresDbContext(DbContextOptions<PostgresDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users { get; set; } = null!;
    public DbSet<Permission> Permissions { get; set; } = null!;
    public DbSet<UserPermission> UserPermissions { get; set; } = null!;
    public DbSet<Report> Reports { get; set; } = null!;
    public DbSet<ReportType> ReportTypes { get; set; } = null!;
    public DbSet<Question> Questions { get; set; } = null!;
    public DbSet<QuestionCategory> QuestionCategories { get; set; } = null!;
    public DbSet<QuestionType> QeustionTypes { get; set; } = null!;
    public DbSet<Form> Forms { get; set; } = null!;


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(PostgresDbContext).Assembly);
        base.OnModelCreating(modelBuilder);
    }
}