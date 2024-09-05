using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.General;
using NuGet.Protocol;
using System.Security.Policy;

namespace Backend_ASP.NET.Data
{
    public class MyAppDBConText: IdentityDbContext<AppilcationUser>
    {
        public MyAppDBConText(DbContextOptions<MyAppDBConText> opt) : base(opt)
        {

        }
        public DbSet<Categories> Categories { get; set; }
        public DbSet<Custommers> Customs { get; set; }
        public DbSet<Debits> Debits { get; set; }
        public DbSet<Employee> Employees { get; set; }
        public DbSet<OrderDetails> OrderDetails { get; set; }
        public DbSet<Orders> Orders { get; set; }
        public DbSet<Payment> Payments { get; set; }
        public DbSet<Products> Products { get; set; }
        public DbSet<ProductSuppliers> ProductSuppliers { get; set; }
        public DbSet<Stores> Stores { get; set; }
        public DbSet<Suppliers> Suppliers { get; set; }
        public DbSet<AppilcationUser> AppilcationUser { get; set; }
        public DbSet<StoreCustomer> StoreCustomer { get; set; }
        public DbSet<StoresSuppliers> StoresSuppliers { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            // Áp dụng cấu hình cho tất cả các thực thể kế thừa từ BaseModel
            foreach (var entityType in modelBuilder.Model.GetEntityTypes())

            {
                if (typeof(BaseModel).IsAssignableFrom(entityType.ClrType))
                {
                    modelBuilder.Entity(entityType.ClrType).Property<DateTime>("CreatedDate")
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");

                    modelBuilder.Entity(entityType.ClrType).Property<DateTime>("UpdateDate")
                        .ValueGeneratedOnUpdate()
                        .HasDefaultValueSql("CURRENT_TIMESTAMP");
                }
            }


            


            //Propenty Configurations Custommers
            modelBuilder.Entity<Custommers>(entity =>
            {
                entity.ToTable("Custommers");
                entity.HasKey(e => e.CustommerId);
                entity.Property(e=>e.Age).HasMaxLength(20);
                entity.HasOne(c => c.Users)
                .WithOne()
                .HasForeignKey<Custommers>(c => c.UserId);



            });

            //Propenty Configurations Debits
            modelBuilder.Entity<Debits>(entity =>
            {
                entity.ToTable("Debtits");
                entity.HasKey(e => e.ID);
                entity.Property(e => e.DebPurchaseDate).HasDefaultValueSql("CURRENT_TIMESTAMP");

                //Relationship  1-1 with Customers
                entity.HasOne(e => e.Custommers)
                .WithOne(d => d.Debits)
                .HasForeignKey<Debits>(d => d.CustomerID);         

            });

           

            //Propemty Configurations Employee
            modelBuilder.Entity<Employee>(entity =>
            {
                entity.ToTable("Employees");
                entity.HasKey(e => e.EmployeeId);

                entity.HasOne(c => c.Users)
                 .WithOne()
                 .HasForeignKey<Employee>(c => c.UserId);

                //Relationship 1-n with Debits
                entity.HasMany(e=>e.Debits)
                .WithOne(e=>e.Employee)
                .HasForeignKey(d => d.EmployeeID);

            });


            //Propemty Configurations Stores
            modelBuilder.Entity<Stores>(entity =>
            {
                entity.ToTable("Stores");
                entity.HasKey(e => e.StoreID);
                entity.Property(e=> e.StoreName).HasMaxLength(50);

                //Relationship 1-n with Debit
                entity.HasMany(e => e.Debits)
                .WithOne(e => e.Stores)
                .HasForeignKey(d => d.StoreID);

                //Relationship 1-n with Employee
                entity.HasMany(e => e.employees)
               .WithOne(e => e.Stores)
               .HasForeignKey(d => d.StoreID);

            });
            //Propemty Configurations StoreCustomer
            modelBuilder.Entity<StoreCustomer>(entity =>
            {
                entity.ToTable("StoreCustommer");
                entity.HasKey(e => new { e.StoreID, e.CustommerID });

                //Relationship 
                entity.HasOne(e => e.Stores)
                .WithMany(e => e.storeCustomers)
                .HasForeignKey(e => e.StoreID);

                entity.HasOne(e => e.Custommers)
               .WithMany(e => e.StoreCustomers)
               .HasForeignKey(e => e.CustommerID);

            });
            //Propemty Configurations Suppliers
            modelBuilder.Entity<Suppliers>(entity =>
            {
                entity.ToTable("Suppliers");
                entity.HasKey(e => e.SupID);
            });

            //Propemty Configurations StoresSuppliers
            modelBuilder.Entity<StoresSuppliers>(entity =>
            {
                entity.ToTable("StoresSuppliers");
                entity.HasKey(e => new { e.StoreID, e.SupplierID });

                //Relationship
                entity.HasOne(e => e.Stores)
                .WithMany(e => e.StoresSuppliers)
                .HasForeignKey(e => e.StoreID);

                entity.HasOne(e => e.Suppliers)
                .WithMany(e => e.StoresSuppliers)
                .HasForeignKey(e => e.SupplierID);
            });

            //Propemty Configurations Products
            modelBuilder.Entity<Products>(entity =>
            {
                entity.ToTable("Products");
                entity.HasKey(e => e.ProductID);

                //Relationship
                entity.HasOne(e => e.Stores)
                .WithMany(e => e.products)
                .HasForeignKey(e => e.StoreID);


                entity.HasOne(e => e.Categories)
                .WithMany(e => e.Products)
                .HasForeignKey(e => e.CategoryID);

            });

            //Propemty Configurations ProductSuppliers
            modelBuilder.Entity<ProductSuppliers>(entity =>
            {
                entity.ToTable("ProductSuppliers");
                entity.HasKey(e => e.ID);
                entity.Property(e => e.SupplierDate).HasDefaultValueSql("CURRENT_TIMESTAMP");

                //Relationship
                entity.HasOne(e => e.Products)
                .WithMany(e => e.ProductSuppliers)
                .HasForeignKey(e => e.ProductID);

                entity.HasOne(e => e.Suppliers)
                .WithMany(e => e.ProductSuppliers)
                .HasForeignKey(e => e.SupID);
            });

            //Propemty Configurations Categories
            modelBuilder.Entity<Categories>(entity =>
            {
                entity.ToTable("Categories");
                entity.HasKey(e => e.CategoryID);

                
            });

            //Propemty Configurations Orders
            modelBuilder.Entity<Orders>(entity =>
            {
                entity.ToTable("Orders");
                entity.HasKey(e => e.ID);
                entity.Property(e => e.ShippperDate).HasDefaultValueSql("CURRENT_TIMESTAMP");

                //Relationship
                entity.HasOne(e => e.Stores)
                .WithMany(e => e.Orders)
                .HasForeignKey(e => e.StoreID);

                entity.HasOne(e => e.Employee)
                .WithMany(e => e.Orders)
                .HasForeignKey(e => e.EmployeeID);

                entity.HasOne(e => e.Custommers)
               .WithMany(e => e.Orders)
               .HasForeignKey(e => e.CustomerID);
            });

            //Propemty Configurations OrderDetails
            modelBuilder.Entity<OrderDetails>(entity =>
            {
                entity.ToTable("OrderDetails");
                entity.HasKey(e => e.ID);

                //Relationship
                entity.HasOne(e => e.Products)
                .WithMany(e => e.OrderDetails)
                .HasForeignKey(e => e.ProductID);

                entity.HasOne(e => e.Orders)
               .WithMany(e => e.OrderDetails)
               .HasForeignKey(e => e.OrderID);
            });

            //Propemty Configurations Payment
            modelBuilder.Entity<Payment>(entity =>
            {
                entity.ToTable("Payment");
                entity.HasKey(e => e.ID);

                //Relationship
                entity.HasOne(e => e.Orders)
                .WithOne(e => e.Payment)
                .HasForeignKey<Payment>(e=> e.OrderID);
            });


        }
    }

    
}
