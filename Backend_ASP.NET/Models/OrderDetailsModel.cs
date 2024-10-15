using Backend_ASP.NET.Data;

namespace Backend_ASP.NET.Models
{
    public class OrderDetailsModel
    {
        public Guid ID { get; set; }
        public string? UnitPrice { get; set; }
        public double? Quantity { get; set; }
        public string? Discount { get; set; }
        public double? SubTotal { get; set; }
        public Guid? ProductID { get; set; }
    }
}
