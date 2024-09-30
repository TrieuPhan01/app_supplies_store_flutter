namespace Backend_ASP.NET.Data
{// Bảng Nhà cung cấp lưu thông tin của nhà cung cấp
    public class Suppliers
    {
        public Guid SupID { set; get; }
        public string? CompanyName { set; get; }// Tên công ty
        public string ? ContactName { set; get; }//Tên người lên hệ
        public string? Address { set; get; }
        public string? City { set; get; }
        public string? PhoneNumber { set; get; }
        public string? Email { set; get; }

        public ICollection<StoresSuppliers> StoresSuppliers { set; get; }   
        public ICollection<ProductSuppliers> ProductSuppliers { set; get; }

        public Suppliers()
        {
            StoresSuppliers = new List<StoresSuppliers>();
            ProductSuppliers = new List<ProductSuppliers>();
        }


    }
}
