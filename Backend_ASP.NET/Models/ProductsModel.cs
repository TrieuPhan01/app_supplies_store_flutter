using Backend_ASP.NET.Data;

namespace Backend_ASP.NET.Models
{
    public class ProductsModel
    {
        public Guid ProductID { get; set; }
        public string? ProductName { get; set; }    
        public int? Price { get; set; }
        public int? StockQuantity { get; set; }// Số lượng hàng tồn kho
        public string? Description { get; set; }// Mô tả sản phẩm
        public string? Picture { get; set; }
        public Boolean Discontinued { get; set; } = true;
        public Guid? StoreID { get; set; }
        public Guid? CategoryID { get; set; }
    }
}
