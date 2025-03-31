using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Statista.Infrastructure.Persistence.Configurations;

public class EnumPositionConfiguration : IEntityTypeConfiguration<EnumPosition>
{
    public void Configure(EntityTypeBuilder<EnumPosition> builder)
    {
        ConfigurePermissionTable(builder);
    }

    private void ConfigurePermissionTable(EntityTypeBuilder<EnumPosition> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("EnumPosition");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(p => p.Id);
    }
}