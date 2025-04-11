﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using Statista.Infrastructure.Persistence;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    [DbContext(typeof(PostgresDbContext))]
    partial class PostgresDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "9.0.0")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("AdminGroup", b =>
                {
                    b.Property<Guid>("SurveyId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("UserId")
                        .HasColumnType("uuid");

                    b.HasKey("SurveyId", "UserId");

                    b.HasIndex("UserId");

                    b.ToTable("AdminGroup", (string)null);
                });

            modelBuilder.Entity("Answer", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("AnswerValueId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("QuestionId")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("SurveyId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("AnswerValueId");

                    b.HasIndex("QuestionId");

                    b.HasIndex("SurveyId");

                    b.ToTable("Answers");
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

            modelBuilder.Entity("RespondentGroup", b =>
                {
                    b.Property<Guid>("SurveyId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("UserId")
                        .HasColumnType("uuid");

                    b.HasKey("SurveyId", "UserId");

                    b.HasIndex("UserId");

                    b.ToTable("RespondentGroup", (string)null);
                });

            modelBuilder.Entity("Statista.Domain.Entities.AvailableAnswer", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("ImageLink")
                        .HasColumnType("text");

                    b.Property<Guid>("QuestionId")
                        .HasColumnType("uuid");

                    b.Property<string>("Text")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("QuestionId");

                    b.ToTable("AvailableAnswers");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Form", b =>
                {
                    b.Property<Guid>("Id")
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

                    b.ToTable("Form", (string)null);
                });

            modelBuilder.Entity("Statista.Domain.Entities.Question", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid>("SectionId")
                        .HasColumnType("uuid");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<Guid?>("TypeId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("SectionId");

                    b.HasIndex("TypeId");

                    b.ToTable("Question", (string)null);
                });

            modelBuilder.Entity("Statista.Domain.Entities.Section", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("FormId")
                        .HasColumnType("uuid");

                    b.Property<int?>("Order")
                        .HasColumnType("integer");

                    b.Property<Guid?>("ParentSectonId")
                        .HasColumnType("uuid");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("FormId");

                    b.HasIndex("ParentSectonId");

                    b.ToTable("Sections");
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

                    b.Property<string>("PasswordHash")
                        .HasColumnType("text");

                    b.Property<DateTime>("UpdatedDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid>("UserInfoId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.ToTable("User", (string)null);
                });

            modelBuilder.Entity("Statista.Domain.Entities.UserInfo", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTime?>("Birthday")
                        .HasColumnType("timestamp with time zone");

                    b.Property<bool?>("IsMan")
                        .HasColumnType("boolean");

                    b.Property<Guid>("UserId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("UserId")
                        .IsUnique();

                    b.ToTable("UserInfo");
                });

            modelBuilder.Entity("Survey", b =>
                {
                    b.Property<Guid>("Id")
                        .HasColumnType("uuid");

                    b.Property<Guid>("CreatedById")
                        .HasColumnType("uuid");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid>("FormId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("CreatedById");

                    b.ToTable("Survey", (string)null);
                });

            modelBuilder.Entity("AdminGroup", b =>
                {
                    b.HasOne("Survey", "Survey")
                        .WithMany()
                        .HasForeignKey("SurveyId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Statista.Domain.Entities.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Survey");

                    b.Navigation("User");
                });

            modelBuilder.Entity("Answer", b =>
                {
                    b.HasOne("Statista.Domain.Entities.AvailableAnswer", "AnswerValue")
                        .WithMany()
                        .HasForeignKey("AnswerValueId");

                    b.HasOne("Statista.Domain.Entities.Question", "Question")
                        .WithMany()
                        .HasForeignKey("QuestionId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Survey", null)
                        .WithMany("answers")
                        .HasForeignKey("SurveyId");

                    b.Navigation("AnswerValue");

                    b.Navigation("Question");
                });

            modelBuilder.Entity("Classifier", b =>
                {
                    b.HasOne("Classifier", "Parent")
                        .WithMany("Children")
                        .HasForeignKey("ParentId");

                    b.Navigation("Parent");
                });

            modelBuilder.Entity("RespondentGroup", b =>
                {
                    b.HasOne("Survey", "Survey")
                        .WithMany()
                        .HasForeignKey("SurveyId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Statista.Domain.Entities.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Survey");

                    b.Navigation("User");
                });

            modelBuilder.Entity("Statista.Domain.Entities.AvailableAnswer", b =>
                {
                    b.HasOne("Statista.Domain.Entities.Question", "Question")
                        .WithMany("AvailableAnswers")
                        .HasForeignKey("QuestionId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Question");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Form", b =>
                {
                    b.HasOne("Statista.Domain.Entities.User", "CreatedBy")
                        .WithMany()
                        .HasForeignKey("CreatedById")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Survey", "Survey")
                        .WithOne("Form")
                        .HasForeignKey("Statista.Domain.Entities.Form", "SurveyId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("CreatedBy");

                    b.Navigation("Survey");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Question", b =>
                {
                    b.HasOne("Statista.Domain.Entities.Section", "Section")
                        .WithMany("Questions")
                        .HasForeignKey("SectionId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Classifier", "Type")
                        .WithMany()
                        .HasForeignKey("TypeId");

                    b.Navigation("Section");

                    b.Navigation("Type");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Section", b =>
                {
                    b.HasOne("Statista.Domain.Entities.Form", "Form")
                        .WithMany("Sections")
                        .HasForeignKey("FormId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Statista.Domain.Entities.Section", "ParentSecton")
                        .WithMany("ChildrenSections")
                        .HasForeignKey("ParentSectonId");

                    b.Navigation("Form");

                    b.Navigation("ParentSecton");
                });

            modelBuilder.Entity("Statista.Domain.Entities.UserInfo", b =>
                {
                    b.HasOne("Statista.Domain.Entities.User", "User")
                        .WithOne("UserInfo")
                        .HasForeignKey("Statista.Domain.Entities.UserInfo", "UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
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

            modelBuilder.Entity("Statista.Domain.Entities.Question", b =>
                {
                    b.Navigation("AvailableAnswers");
                });

            modelBuilder.Entity("Statista.Domain.Entities.Section", b =>
                {
                    b.Navigation("ChildrenSections");

                    b.Navigation("Questions");
                });

            modelBuilder.Entity("Statista.Domain.Entities.User", b =>
                {
                    b.Navigation("UserInfo")
                        .IsRequired();
                });

            modelBuilder.Entity("Survey", b =>
                {
                    b.Navigation("Form")
                        .IsRequired();

                    b.Navigation("answers");
                });
#pragma warning restore 612, 618
        }
    }
}
