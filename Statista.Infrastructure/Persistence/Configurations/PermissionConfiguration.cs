using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Statista.Infrastructure.Persistence.Configurations;

public class PermissionConfiguration : IEntityTypeConfiguration<Permission>
{
    public void Configure(EntityTypeBuilder<Permission> builder)
    {
        ConfigurePermissionTable(builder);
    }

    private void ConfigurePermissionTable(EntityTypeBuilder<Permission> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("Permission");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(p => p.Id);
    }
}