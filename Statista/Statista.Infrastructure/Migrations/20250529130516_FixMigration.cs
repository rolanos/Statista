using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class FixMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Form_User_CreatedById",
                table: "Form");

            migrationBuilder.DropIndex(
                name: "IX_Form_CreatedById",
                table: "Form");

            migrationBuilder.DropColumn(
                name: "CreatedById",
                table: "Form");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "CreatedById",
                table: "Form",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Form_CreatedById",
                table: "Form",
                column: "CreatedById");

            migrationBuilder.AddForeignKey(
                name: "FK_Form_User_CreatedById",
                table: "Form",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
