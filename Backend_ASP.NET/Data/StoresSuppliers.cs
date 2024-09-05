namespace Backend_ASP.NET.Data
{
    public class StoresSuppliers
    {
        public Guid StoreID { get; set; }
        public Stores? Stores { get; set; }

        public Guid? SupplierID { get; set; }
        public Suppliers? Suppliers { get; set; }
    }
}
