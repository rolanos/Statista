using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class ReportConfigurations : IEntityTypeConfiguration<Report>
{
    public void Configure(EntityTypeBuilder<Report> builder)
    {
        ConfigureReportTable(builder);
    }

    private void ConfigureReportTable(EntityTypeBuilder<Report> builder)
    {
        builder.ToTable("Report");
        builder.HasKey(x => x.Id);
        builder.HasOne(x => x.ReportType).WithMany().HasForeignKey(x => x.ReportTypeId);
        builder.HasOne(x => x.ReportedQuestion).WithMany();
        builder.HasOne(x => x.CreatedBy).WithMany().HasForeignKey(x => x.CreatedById);
    }
}