using Backend_ASP.NET.Data;

namespace Backend_ASP.NET.Models
{
    public class DebitsModel
    {
        public Guid? ID { get; set; }
        public string? Name { get; set; }
        public string? Note { get; set; }
        public int? TotalMoney { get; set; }
        public bool PaymentStatus { get; set; } = false;// Trạng thái của hóa đơn đã được thanh toán hay chưa
        public DateTime? DebPurchaseDate { get; set; }
        public Guid? CustomerID { get; set; }
        public Guid? EmployeeID { get; set; }
        public Guid? StoreID { get; set; }

    }
}


