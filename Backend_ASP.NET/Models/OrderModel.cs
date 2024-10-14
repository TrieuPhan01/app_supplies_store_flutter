using Backend_ASP.NET.Data;

namespace Backend_ASP.NET.Models
{
   
    public class OrderModel
    {
        public Guid Id { get; set; }
        public string? ShipAddress { get; set; }
        public DateTime? ShippperDate { get; set; }
        public double? TotalAmount { get; set; }
        public bool? OrderStatus { get; set; }
        public string? PaymentType { get; set; }
        public Guid? StoreID { get; set; }
        public Guid? EmployeeID { get; set; }
        public Guid? CustomerID { get; set; }
        public List<OrderDetailsModel>? OrderDetails { get; set; }
    }
}
