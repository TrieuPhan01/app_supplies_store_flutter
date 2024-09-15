using Backend_ASP.NET.Data;

namespace Backend_ASP.NET.Models
{
    public class EmployeesModel
    {
        public Guid EmployeeId { get; set; }
        public DateTime? HireDate { get; set; }// Ngày thê/ký kết hợp đồng
        public int? Salary { get; set; }// Tiền lương
        public string? Position { get; set; }// Chức vụ
        public bool Status { get; set; } = true;// Trạng thái làm việc còn hay không?

        public string? UserId { get; set; }

        public Guid? StoreID { get; set; }
    }
}
