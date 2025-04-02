using Microsoft.EntityFrameworkCore;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence;

public class PostgresDbContext : DbContext
{
    public PostgresDbContext(DbContextOptions<PostgresDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users { get; set; } = null!;

    public DbSet<Survey> Surveys { get; set; } = null!;

    public DbSet<Form> Forms { get; set; } = null!;

    public DbSet<Section> Sections { get; set; } = null!;

    public DbSet<Question> Questions { get; set; } = null!;


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(PostgresDbContext).Assembly);
        base.OnModelCreating(modelBuilder);
    }
}