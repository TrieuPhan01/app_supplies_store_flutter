namespace Backend_ASP.NET.Data
{// Bảng chi tiết đơn hàng
    public class OrderDetails
    {
        public Guid ID { get; set; }
        public int? UnitPrice { get; set; }// Đơn giá
        public double? Quantity { get; set; }//Số lượng
        public string? Discount { get; set; }
        public double? SubTotal { get; set; }// Tổng tiền = unitPrice * quantity

        //Relationship
        public Guid? ProductID { get; set; }
        public Products? Products { get; set; }

        public Guid? OrderID { get; set; }
        public  Orders? Orders { get; set; }


    }
}
