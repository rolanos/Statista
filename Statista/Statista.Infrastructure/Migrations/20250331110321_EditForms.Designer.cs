﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using Statista.Infrastructure.Persistence;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    [DbContext(typeof(PostgresDbContext))]
    [Migration("20250331110321_EditForms")]
    partial class EditForms
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "9.0.0")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("Answer", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("AnswerValueId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("RespondentId")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("SurveyId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("AnswerValueId");

                    b.HasIndex("RespondentId");

                    b.HasIndex("SurveyId");

                    b.ToTable("Answer");
                });

            modelBuilder.Entity("Classifier", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<Guid?>("ParentId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("ParentId");

                    b.ToTable("Classifier", (string)null);
                });

            modelBuilder.Entity("EnumPosition", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("ClassifierId")
                        .HasColumnType("uuid");

                    b.Property<string>("ImageLink")
                        .HasColumnType("text");

                    b.Property<string>("Text")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("ClassifierId");

                    b.ToTable("EnumPosition", (string)null);
                });

            modelBuilder.Entity("Statista.Domain.Entities.Form", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("CreatedById")
                        .HasColumnType("uuid");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<Guid>("SurveyId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("CreatedById");

                    b.HasIndex("SurveyId")
                        .IsUnique();

                    b.ToTable("Forms");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Question", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("CreatedById")
                        .HasColumnType("uuid");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid>("FormId")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("SectionId")
                        .HasColumnType("uuid");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<Guid?>("TypeId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("CreatedById");

                    b.HasIndex("FormId");

                    b.HasIndex("SectionId");

                    b.HasIndex("TypeId");

                    b.ToTable("Question", (string)null);
                });

            modelBuilder.Entity("Statista.Domain.Entities.Section", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("FormId")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("SectionId")
                        .HasColumnType("uuid");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int?>("order")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("FormId");

                    b.HasIndex("SectionId");

                    b.ToTable("Section");
                });

            modelBuilder.Entity("Statista.Domain.Entities.User", b =>
                {
                    b.Property<Guid>("Id")
                        .HasColumnType("uuid");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<string>("Name")
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<string>("PasswordHash")
                        .HasColumnType("text");

                    b.Property<string>("Surname")
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)");

                    b.Property<DateTime>("UpdatedDate")
                        .HasColumnType("timestamp with time zone");

                    b.HasKey("Id");

                    b.ToTable("User", (string)null);
                });

            modelBuilder.Entity("Survey", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("CreatedById")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("CreatedById");

                    b.ToTable("Surveys");
                });

            modelBuilder.Entity("Answer", b =>
                {
                    b.HasOne("EnumPosition", "AnswerValue")
                        .WithMany()
                        .HasForeignKey("AnswerValueId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Statista.Domain.Entities.User", "Respondent")
                        .WithMany()
                        .HasForeignKey("RespondentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Survey", null)
                        .WithMany("answers")
                        .HasForeignKey("SurveyId");

                    b.Navigation("AnswerValue");

                    b.Navigation("Respondent");
                });

            modelBuilder.Entity("Classifier", b =>
                {
                    b.HasOne("Classifier", "Parent")
                        .WithMany("Children")
                        .HasForeignKey("ParentId");

                    b.Navigation("Parent");
                });

            modelBuilder.Entity("EnumPosition", b =>
                {
                    b.HasOne("Classifier", "Classifier")
                        .WithMany()
                        .HasForeignKey("ClassifierId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Classifier");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Form", b =>
                {
                    b.HasOne("Statista.Domain.Entities.User", "CreatedBy")
                        .WithMany()
                        .HasForeignKey("CreatedById")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Survey", "Survey")
                        .WithOne("form")
                        .HasForeignKey("Statista.Domain.Entities.Form", "SurveyId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("CreatedBy");

                    b.Navigation("Survey");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Question", b =>
                {
                    b.HasOne("Statista.Domain.Entities.User", "CreatedBy")
                        .WithMany()
                        .HasForeignKey("CreatedById")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Statista.Domain.Entities.Form", "Form")
                        .WithMany()
                        .HasForeignKey("FormId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Statista.Domain.Entities.Section", null)
                        .WithMany("questions")
                        .HasForeignKey("SectionId");

                    b.HasOne("Classifier", "Type")
                        .WithMany()
                        .HasForeignKey("TypeId");

                    b.Navigation("CreatedBy");

                    b.Navigation("Form");

                    b.Navigation("Type");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Section", b =>
                {
                    b.HasOne("Statista.Domain.Entities.Form", null)
                        .WithMany("Sections")
                        .HasForeignKey("FormId");

                    b.HasOne("Statista.Domain.Entities.Section", null)
                        .WithMany("sections")
                        .HasForeignKey("SectionId");
                });

            modelBuilder.Entity("Survey", b =>
                {
                    b.HasOne("Statista.Domain.Entities.User", "CreatedBy")
                        .WithMany()
                        .HasForeignKey("CreatedById")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("CreatedBy");
                });

            modelBuilder.Entity("Classifier", b =>
                {
                    b.Navigation("Children");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Form", b =>
                {
                    b.Navigation("Sections");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Section", b =>
                {
                    b.Navigation("questions");

                    b.Navigation("sections");
                });

            modelBuilder.Entity("Survey", b =>
                {
                    b.Navigation("answers");

                    b.Navigation("form");
                });
#pragma warning restore 612, 618
        }
    }
}
