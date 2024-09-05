namespace Backend_ASP.NET.Data
{// Bảng lưu thông tin đã thanh toán
    public class Payment: BaseModel
    { 
        public int? AmountPaid { get; set; }//Số tiền đã trả 
        public String? PaymentMethod { get; set; }
        public  bool PaymentStatus { get; set; }=false;//Trạng thái

        //Relationship
        public Guid? OrderID { get; set; }
        public Orders? Orders { get; set; }
    }
}
