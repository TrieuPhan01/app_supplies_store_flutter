namespace Backend_ASP.NET.Data
{
    public class ProductSuppliers
    {
        public Guid ID { get; set; }  
        public int? SupplierPrice { get; set; }
        public DateTime SupplierDate { get; set; }
        public int Quantity { get; set; }

        public Guid? SupID { get; set; }
        public Suppliers? Suppliers { get; set; }

        public Guid? ProductID { get; set; }
        public Products? Products { get; set; }
    }
}
