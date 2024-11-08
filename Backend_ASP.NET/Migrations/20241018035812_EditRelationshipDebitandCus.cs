using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend_ASP.NET.Migrations
{
    /// <inheritdoc />
    public partial class EditRelationshipDebitandCus : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Debtits_Custommers_CustomerID",
                table: "Debtits");

            migrationBuilder.DropIndex(
                name: "IX_Debtits_CustomerID",
                table: "Debtits");

            migrationBuilder.AddColumn<Guid>(
                name: "DebitsID",
                table: "Custommers",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Debtits_CustomerID",
                table: "Debtits",
                column: "CustomerID");

            migrationBuilder.CreateIndex(
                name: "IX_Custommers_DebitsID",
                table: "Custommers",
                column: "DebitsID");

            migrationBuilder.AddForeignKey(
                name: "FK_Custommers_Debtits_DebitsID",
                table: "Custommers",
                column: "DebitsID",
                principalTable: "Debtits",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Debtits_Custommers_CustomerID",
                table: "Debtits",
                column: "CustomerID",
                principalTable: "Custommers",
                principalColumn: "CustommerId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Custommers_Debtits_DebitsID",
                table: "Custommers");

            migrationBuilder.DropForeignKey(
                name: "FK_Debtits_Custommers_CustomerID",
                table: "Debtits");

            migrationBuilder.DropIndex(
                name: "IX_Debtits_CustomerID",
                table: "Debtits");

            migrationBuilder.DropIndex(
                name: "IX_Custommers_DebitsID",
                table: "Custommers");

            migrationBuilder.DropColumn(
                name: "DebitsID",
                table: "Custommers");

            migrationBuilder.CreateIndex(
                name: "IX_Debtits_CustomerID",
                table: "Debtits",
                column: "CustomerID",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Debtits_Custommers_CustomerID",
                table: "Debtits",
                column: "CustomerID",
                principalTable: "Custommers",
                principalColumn: "CustommerId");
        }
    }
}
