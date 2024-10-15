namespace Backend_ASP.NET.Models
{
    public class PaymentModel
    {
        public Guid? ID { get; set; }
        public int? AmountPaid { get; set; }//Số tiền đã trả 
        public string? PaymentMethod { get; set; }
        public bool PaymentStatus { get; set; } = false;//Trạng thái
        public string? TransactionCode { get; set; }
        public Guid? OrderID { get; set; }
    }
}
