namespace Backend_ASP.NET.Data
{// Bảng lưu thông tin cửa hàng
    public class Stores
    {
        public Guid StoreID { get; set; }
        public string? StoreName { get; set; }
        public string? Address { get; set; }
        public string? ImageStore { get; set; }

        public ICollection<Debits> Debits { get; set; }

        public ICollection<StoreCustomer> storeCustomers { get; set; }

        public ICollection<Employee> employees { get; set; }
        public ICollection<StoresSuppliers> StoresSuppliers { get; set; }
        public ICollection<Products> products { get; set; }

        public ICollection<Orders> Orders { get; set; }

        public Stores()
        {
            Debits = new List<Debits>();
            storeCustomers = new List<StoreCustomer>();
            employees = new List<Employee>();
            StoresSuppliers = new List<StoresSuppliers>();
            Debits = new List<Debits>();
            products = new List<Products>();
            Orders = new List<Orders>();

        }
    }
        

}