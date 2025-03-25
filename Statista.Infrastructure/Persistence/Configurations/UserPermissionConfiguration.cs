using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class UserPermissionConfigurations : IEntityTypeConfiguration<UserPermission>
{
    public void Configure(EntityTypeBuilder<UserPermission> builder)
    {
        ConfigureUserPermissionTable(builder);
    }

    private void ConfigureUserPermissionTable(EntityTypeBuilder<UserPermission> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("UserPermission");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(u => new { u.UserId, u.PermissionId });
    }
}