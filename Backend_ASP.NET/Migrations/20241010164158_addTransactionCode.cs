using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend_ASP.NET.Migrations
{
    /// <inheritdoc />
    public partial class addTransactionCode : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "TransactionCode",
                table: "Payment",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "TransactionCode",
                table: "Payment");
        }
    }
}
