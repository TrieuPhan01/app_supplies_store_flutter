namespace Backend_ASP.NET.Data
{
    //Bảng đơn hàng
    public enum paymentEnum
    {
        MoMo, ZaloPay
    }
    public class Orders: BaseModel
    {
        public string? ShipAddress { get; set; }
        public DateTime? ShippperDate { get; set; }
        public int?  TotalAmount { get; set; }
        public bool? OrderStatus { get; set; }
        public paymentEnum PaymentType { get; set; }

        public Guid? StoreID { get; set; }
        public Stores Stores { get; set; } 
        
        public Guid? EmployeeID {  get; set; }
        public Employee Employee { get; set; }

        public Guid? CustomerID { get; set; }
        public Custommers Custommers { get; set; }

        public ICollection<OrderDetails> OrderDetails { get; set; }

        public Payment Payment { get; set; }

        public Orders()
        {
            OrderDetails = new List<OrderDetails>();
           
        }



    }
}
