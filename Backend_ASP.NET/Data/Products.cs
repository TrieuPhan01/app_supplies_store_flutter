using System.Text.Json.Serialization;
namespace Backend_ASP.NET.Data
{// Bảng lưu thông tin các sản phẩm
    public class Products
    {
        public Guid ProductID {  get; set; }
        public string? ProductName { get; set; }
        public int? Price { get; set; }
        public int? StockQuantity { get; set; }// Số lượng hàng tồn kho
        public string? Description { get; set; }// Mô tả sản phẩm
        public string? Picture { get; set; }
        public Boolean Discontinued { get; set; }= true;

        public ICollection<ProductSuppliers> ProductSuppliers { get; set; }

        public Guid? StoreID { get; set; }
        public Stores Stores { get; set; } 

        public Guid? CategoryID { get; set; }
        [JsonIgnore]
        public Categories Categories { get; set; }

        public ICollection<OrderDetails> OrderDetails { get; set; } 

        public Products() 
        { 
            OrderDetails = new List<OrderDetails>();
            ProductSuppliers= new List<ProductSuppliers>();
        }
        

    }

}
