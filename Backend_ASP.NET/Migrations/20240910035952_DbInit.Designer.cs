﻿// <auto-generated />
using System;
using Backend_ASP.NET.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Backend_ASP.NET.Migrations
{
    [DbContext(typeof(MyAppDBConText))]
    [Migration("20240910035952_DbInit")]
    partial class DbInit
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.8")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("Backend_ASP.NET.Data.ApplicationUser", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("text");

                    b.Property<int>("AccessFailedCount")
                        .HasColumnType("integer");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("text");

                    b.Property<string>("Email")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<bool>("EmailConfirmed")
                        .HasColumnType("boolean");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<bool>("LockoutEnabled")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset?>("LockoutEnd")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("NormalizedEmail")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("NormalizedUserName")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("PasswordHash")
                        .HasColumnType("text");

                    b.Property<string>("PhoneNumber")
                        .HasColumnType("text");

                    b.Property<bool>("PhoneNumberConfirmed")
                        .HasColumnType("boolean");

                    b.Property<string>("SecurityStamp")
                        .HasColumnType("text");

                    b.Property<bool>("TwoFactorEnabled")
                        .HasColumnType("boolean");

                    b.Property<string>("UserName")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedEmail")
                        .HasDatabaseName("EmailIndex");

                    b.HasIndex("NormalizedUserName")
                        .IsUnique()
                        .HasDatabaseName("UserNameIndex");

                    b.ToTable("AspNetUsers", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Categories", b =>
                {
                    b.Property<Guid>("CategoryID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Name")
                        .HasColumnType("text");

                    b.Property<string>("Note")
                        .HasColumnType("text");

                    b.Property<string>("Unit")
                        .HasColumnType("text");

                    b.HasKey("CategoryID");

                    b.ToTable("Categories", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Custommers", b =>
                {
                    b.Property<Guid>("CustommerId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Address")
                        .HasColumnType("text");

                    b.Property<int?>("Age")
                        .HasMaxLength(20)
                        .HasColumnType("integer");

                    b.Property<string>("Avatar")
                        .HasColumnType("text");

                    b.Property<int?>("Sex")
                        .HasColumnType("integer");

                    b.Property<string>("UserId")
                        .HasColumnType("text");

                    b.HasKey("CustommerId");

                    b.HasIndex("UserId")
                        .IsUnique();

                    b.ToTable("Custommers", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Debits", b =>
                {
                    b.Property<Guid?>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTime>("CreatedDate")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    b.Property<Guid?>("CustomerID")
                        .HasColumnType("uuid");

                    b.Property<DateTime?>("DebPurchaseDate")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    b.Property<Guid?>("EmployeeID")
                        .HasColumnType("uuid");

                    b.Property<string>("Name")
                        .HasColumnType("text");

                    b.Property<string>("Note")
                        .HasColumnType("text");

                    b.Property<bool>("PaymentStatus")
                        .HasColumnType("boolean");

                    b.Property<Guid?>("StoreID")
                        .HasColumnType("uuid");

                    b.Property<int?>("TotalMoney")
                        .HasColumnType("integer");

                    b.Property<DateTime>("UpdateDate")
                        .ValueGeneratedOnUpdate()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    b.HasKey("ID");

                    b.HasIndex("CustomerID")
                        .IsUnique();

                    b.HasIndex("EmployeeID");

                    b.HasIndex("StoreID");

                    b.ToTable("Debtits", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Employee", b =>
                {
                    b.Property<Guid>("EmployeeId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTime?>("HireDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Position")
                        .HasColumnType("text");

                    b.Property<int?>("Salary")
                        .HasColumnType("integer");

                    b.Property<bool>("Status")
                        .HasColumnType("boolean");

                    b.Property<Guid?>("StoreID")
                        .HasColumnType("uuid");

                    b.Property<string>("UserId")
                        .HasColumnType("text");

                    b.HasKey("EmployeeId");

                    b.HasIndex("StoreID");

                    b.HasIndex("UserId")
                        .IsUnique();

                    b.ToTable("Employees", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.OrderDetails", b =>
                {
                    b.Property<Guid>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Discount")
                        .HasColumnType("text");

                    b.Property<Guid?>("OrderID")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("ProductID")
                        .HasColumnType("uuid");

                    b.Property<double?>("Quantity")
                        .HasColumnType("double precision");

                    b.Property<double?>("SubTotal")
                        .HasColumnType("double precision");

                    b.Property<int?>("UnitPrice")
                        .HasColumnType("integer");

                    b.HasKey("ID");

                    b.HasIndex("OrderID");

                    b.HasIndex("ProductID");

                    b.ToTable("OrderDetails", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Orders", b =>
                {
                    b.Property<Guid?>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTime>("CreatedDate")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    b.Property<Guid?>("CustomerID")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("EmployeeID")
                        .HasColumnType("uuid");

                    b.Property<bool?>("OrderStatus")
                        .HasColumnType("boolean");

                    b.Property<int>("PaymentType")
                        .HasColumnType("integer");

                    b.Property<string>("ShipAddress")
                        .HasColumnType("text");

                    b.Property<DateTime?>("ShippperDate")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    b.Property<Guid?>("StoreID")
                        .HasColumnType("uuid");

                    b.Property<int?>("TotalAmount")
                        .HasColumnType("integer");

                    b.Property<DateTime>("UpdateDate")
                        .ValueGeneratedOnUpdate()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    b.HasKey("ID");

                    b.HasIndex("CustomerID");

                    b.HasIndex("EmployeeID");

                    b.HasIndex("StoreID");

                    b.ToTable("Orders", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Payment", b =>
                {
                    b.Property<Guid?>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int?>("AmountPaid")
                        .HasColumnType("integer");

                    b.Property<DateTime>("CreatedDate")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    b.Property<Guid?>("OrderID")
                        .HasColumnType("uuid");

                    b.Property<string>("PaymentMethod")
                        .HasColumnType("text");

                    b.Property<bool>("PaymentStatus")
                        .HasColumnType("boolean");

                    b.Property<DateTime>("UpdateDate")
                        .ValueGeneratedOnUpdate()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    b.HasKey("ID");

                    b.HasIndex("OrderID")
                        .IsUnique();

                    b.ToTable("Payment", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.ProductSuppliers", b =>
                {
                    b.Property<Guid>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("ProductID")
                        .HasColumnType("uuid");

                    b.Property<int>("Quantity")
                        .HasColumnType("integer");

                    b.Property<Guid?>("SupID")
                        .HasColumnType("uuid");

                    b.Property<DateTime>("SupplierDate")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    b.Property<int?>("SupplierPrice")
                        .HasColumnType("integer");

                    b.HasKey("ID");

                    b.HasIndex("ProductID");

                    b.HasIndex("SupID");

                    b.ToTable("ProductSuppliers", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Products", b =>
                {
                    b.Property<Guid>("ProductID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("CategoryID")
                        .HasColumnType("uuid");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<bool>("Discontinued")
                        .HasColumnType("boolean");

                    b.Property<string>("Picture")
                        .HasColumnType("text");

                    b.Property<int?>("Price")
                        .HasColumnType("integer");

                    b.Property<string>("ProductName")
                        .HasColumnType("text");

                    b.Property<int?>("StockQuantity")
                        .HasColumnType("integer");

                    b.Property<Guid?>("StoreID")
                        .HasColumnType("uuid");

                    b.HasKey("ProductID");

                    b.HasIndex("CategoryID");

                    b.HasIndex("StoreID");

                    b.ToTable("Products", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.StoreCustomer", b =>
                {
                    b.Property<Guid>("StoreID")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("CustommerID")
                        .HasColumnType("uuid");

                    b.HasKey("StoreID", "CustommerID");

                    b.HasIndex("CustommerID");

                    b.ToTable("StoreCustommer", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Stores", b =>
                {
                    b.Property<Guid>("StoreID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Address")
                        .HasColumnType("text");

                    b.Property<string>("ImageStore")
                        .HasColumnType("text");

                    b.Property<string>("StoreName")
                        .HasMaxLength(50)
                        .HasColumnType("character varying(50)");

                    b.HasKey("StoreID");

                    b.ToTable("Stores", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.StoresSuppliers", b =>
                {
                    b.Property<Guid>("StoreID")
                        .HasColumnType("uuid");

                    b.Property<Guid?>("SupplierID")
                        .HasColumnType("uuid");

                    b.HasKey("StoreID", "SupplierID");

                    b.HasIndex("SupplierID");

                    b.ToTable("StoresSuppliers", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Suppliers", b =>
                {
                    b.Property<Guid>("SupID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Address")
                        .HasColumnType("text");

                    b.Property<string>("City")
                        .HasColumnType("text");

                    b.Property<string>("CompanyName")
                        .HasColumnType("text");

                    b.Property<string>("ContactName")
                        .HasColumnType("text");

                    b.Property<string>("Email")
                        .HasColumnType("text");

                    b.Property<string>("PhoneNumber")
                        .HasColumnType("text");

                    b.HasKey("SupID");

                    b.ToTable("Suppliers", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRole", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("text");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("text");

                    b.Property<string>("Discriminator")
                        .IsRequired()
                        .HasMaxLength(21)
                        .HasColumnType("character varying(21)");

                    b.Property<string>("Name")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("NormalizedName")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedName")
                        .IsUnique()
                        .HasDatabaseName("RoleNameIndex");

                    b.ToTable("AspNetRoles", (string)null);

                    b.HasDiscriminator().HasValue("IdentityRole");

                    b.UseTphMappingStrategy();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("ClaimType")
                        .HasColumnType("text");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("text");

                    b.Property<string>("RoleId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetRoleClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("ClaimType")
                        .HasColumnType("text");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("text");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.Property<string>("LoginProvider")
                        .HasColumnType("text");

                    b.Property<string>("ProviderKey")
                        .HasColumnType("text");

                    b.Property<string>("ProviderDisplayName")
                        .HasColumnType("text");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("LoginProvider", "ProviderKey");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserLogins", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("text");

                    b.Property<string>("RoleId")
                        .HasColumnType("text");

                    b.Property<string>("Discriminator")
                        .IsRequired()
                        .HasMaxLength(34)
                        .HasColumnType("character varying(34)");

                    b.HasKey("UserId", "RoleId");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetUserRoles", (string)null);

                    b.HasDiscriminator().HasValue("IdentityUserRole<string>");

                    b.UseTphMappingStrategy();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("text");

                    b.Property<string>("LoginProvider")
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .HasColumnType("text");

                    b.Property<string>("Value")
                        .HasColumnType("text");

                    b.HasKey("UserId", "LoginProvider", "Name");

                    b.ToTable("AspNetUserTokens", (string)null);
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.ApplicationRole", b =>
                {
                    b.HasBaseType("Microsoft.AspNetCore.Identity.IdentityRole");

                    b.Property<string>("RoleName")
                        .HasColumnType("text");

                    b.HasDiscriminator().HasValue("ApplicationRole");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.ApplicationUserRole", b =>
                {
                    b.HasBaseType("Microsoft.AspNetCore.Identity.IdentityUserRole<string>");

                    b.HasDiscriminator().HasValue("ApplicationUserRole");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Custommers", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.ApplicationUser", "Users")
                        .WithOne()
                        .HasForeignKey("Backend_ASP.NET.Data.Custommers", "UserId");

                    b.Navigation("Users");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Debits", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.Custommers", "Custommers")
                        .WithOne("Debits")
                        .HasForeignKey("Backend_ASP.NET.Data.Debits", "CustomerID");

                    b.HasOne("Backend_ASP.NET.Data.Employee", "Employee")
                        .WithMany("Debits")
                        .HasForeignKey("EmployeeID");

                    b.HasOne("Backend_ASP.NET.Data.Stores", "Stores")
                        .WithMany("Debits")
                        .HasForeignKey("StoreID");

                    b.Navigation("Custommers");

                    b.Navigation("Employee");

                    b.Navigation("Stores");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Employee", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.Stores", "Stores")
                        .WithMany("employees")
                        .HasForeignKey("StoreID");

                    b.HasOne("Backend_ASP.NET.Data.ApplicationUser", "Users")
                        .WithOne()
                        .HasForeignKey("Backend_ASP.NET.Data.Employee", "UserId");

                    b.Navigation("Stores");

                    b.Navigation("Users");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.OrderDetails", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.Orders", "Orders")
                        .WithMany("OrderDetails")
                        .HasForeignKey("OrderID");

                    b.HasOne("Backend_ASP.NET.Data.Products", "Products")
                        .WithMany("OrderDetails")
                        .HasForeignKey("ProductID");

                    b.Navigation("Orders");

                    b.Navigation("Products");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Orders", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.Custommers", "Custommers")
                        .WithMany("Orders")
                        .HasForeignKey("CustomerID");

                    b.HasOne("Backend_ASP.NET.Data.Employee", "Employee")
                        .WithMany("Orders")
                        .HasForeignKey("EmployeeID");

                    b.HasOne("Backend_ASP.NET.Data.Stores", "Stores")
                        .WithMany("Orders")
                        .HasForeignKey("StoreID");

                    b.Navigation("Custommers");

                    b.Navigation("Employee");

                    b.Navigation("Stores");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Payment", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.Orders", "Orders")
                        .WithOne("Payment")
                        .HasForeignKey("Backend_ASP.NET.Data.Payment", "OrderID");

                    b.Navigation("Orders");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.ProductSuppliers", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.Products", "Products")
                        .WithMany("ProductSuppliers")
                        .HasForeignKey("ProductID");

                    b.HasOne("Backend_ASP.NET.Data.Suppliers", "Suppliers")
                        .WithMany("ProductSuppliers")
                        .HasForeignKey("SupID");

                    b.Navigation("Products");

                    b.Navigation("Suppliers");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Products", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.Categories", "Categories")
                        .WithMany("Products")
                        .HasForeignKey("CategoryID");

                    b.HasOne("Backend_ASP.NET.Data.Stores", "Stores")
                        .WithMany("products")
                        .HasForeignKey("StoreID");

                    b.Navigation("Categories");

                    b.Navigation("Stores");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.StoreCustomer", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.Custommers", "Custommers")
                        .WithMany("StoreCustomers")
                        .HasForeignKey("CustommerID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Backend_ASP.NET.Data.Stores", "Stores")
                        .WithMany("storeCustomers")
                        .HasForeignKey("StoreID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Custommers");

                    b.Navigation("Stores");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.StoresSuppliers", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.Stores", "Stores")
                        .WithMany("StoresSuppliers")
                        .HasForeignKey("StoreID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Backend_ASP.NET.Data.Suppliers", "Suppliers")
                        .WithMany("StoresSuppliers")
                        .HasForeignKey("SupplierID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Stores");

                    b.Navigation("Suppliers");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.ApplicationUserRole", b =>
                {
                    b.HasOne("Backend_ASP.NET.Data.ApplicationRole", "Role")
                        .WithMany("UserRoles")
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Backend_ASP.NET.Data.ApplicationUser", "User")
                        .WithMany("UserRoles")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Role");

                    b.Navigation("User");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.ApplicationUser", b =>
                {
                    b.Navigation("UserRoles");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Categories", b =>
                {
                    b.Navigation("Products");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Custommers", b =>
                {
                    b.Navigation("Debits");

                    b.Navigation("Orders");

                    b.Navigation("StoreCustomers");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Employee", b =>
                {
                    b.Navigation("Debits");

                    b.Navigation("Orders");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Orders", b =>
                {
                    b.Navigation("OrderDetails");

                    b.Navigation("Payment")
                        .IsRequired();
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Products", b =>
                {
                    b.Navigation("OrderDetails");

                    b.Navigation("ProductSuppliers");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Stores", b =>
                {
                    b.Navigation("Debits");

                    b.Navigation("Orders");

                    b.Navigation("StoresSuppliers");

                    b.Navigation("employees");

                    b.Navigation("products");

                    b.Navigation("storeCustomers");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.Suppliers", b =>
                {
                    b.Navigation("ProductSuppliers");

                    b.Navigation("StoresSuppliers");
                });

            modelBuilder.Entity("Backend_ASP.NET.Data.ApplicationRole", b =>
                {
                    b.Navigation("UserRoles");
                });
#pragma warning restore 612, 618
        }
    }
}
