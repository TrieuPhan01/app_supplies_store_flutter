namespace Backend_ASP.NET.Data
{ // Bảng nhân viên dùng để lưu các 
    public class Employee
    {
        public Guid EmployeeId { get; set; }
        public DateTime? HireDate {  get; set; }// Ngày thê/ký kết hợp đồng
        public  int? Salary { get; set; }// Tiền lương
        public string? Position { get; set; }// Chức vụ
        public bool Status { get; set; }=true;// Trạng thái làm việc còn hay không?
    

        public ICollection<Debits> Debits { get; set; } 

        public string? UserId { get; set; }
        public ApplicationUser Users { get; set; }

        public Guid? StoreID { get; set; }  
        public Stores Stores { get; set; }

        public ICollection<Orders> Orders { get; set; }

        public Employee()
        {
            Orders = new List<Orders>();
            Debits = new List<Debits>();
            
        }
    }
}
