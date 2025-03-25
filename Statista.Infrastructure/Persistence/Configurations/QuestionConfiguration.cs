using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class QuestionConfigurations : IEntityTypeConfiguration<Question>
{
    public void Configure(EntityTypeBuilder<Question> builder)
    {
        ConfigureQuestionTable(builder);
    }

    private void ConfigureQuestionTable(EntityTypeBuilder<Question> builder)
    {
        builder.ToTable("Question");
        builder.HasKey(x => x.Id);
        builder.HasOne(x => x.Form).WithMany(x => x.Questions).HasForeignKey(x => x.FormId);
        builder.HasOne(x => x.CreatedBy).WithMany().HasForeignKey(x => x.CreatedById);
    }
}