namespace Backend_ASP.NET.Data
{
    //Model Debis dùng để lưu dữ liệu ghi nợ của người dùng 
    public class Debits: BaseModel
    {
        public string? Name { get; set; }
        public string? Note { get; set; }
        public int? TotalMoney { get; set; }
        public bool PaymentStatus { get; set; } = false;// Trạng thái của hóa đơn đã được thanh toán hay chưa
        public DateTime? DebPurchaseDate { get; set; }


        // Relationship
        public Guid? CustomerID { get; set; }
        public Custommers? Custommers { get; set; }

        public Guid? EmployeeID { get; set; }
        public Employee? Employee { get; set; }

        public Guid? StoreID { get; set; }
        public Stores? Stores { get; set; }

    }
}
