using DevHabit.Api.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace DevHabit.Api.Database.Configurations;

public sealed class TagConfiguration : IEntityTypeConfiguration<Tag>
{
    public void Configure(EntityTypeBuilder<Tag> builder)
    {
        builder.HasKey(tag => tag.Id);
        builder.Property(tag => tag.Id).HasMaxLength(500);
        builder.Property(tag => tag.UserId).HasMaxLength(500);
        builder.Property(tag => tag.Name).HasMaxLength(50);
        builder.Property(tag => tag.Description).HasMaxLength(500);
        builder.HasIndex(tag => new { tag.UserId, tag.Name }).IsUnique();
        builder.HasOne<User>()
            .WithMany()
            .HasForeignKey(tag => tag.UserId);
    }
}
