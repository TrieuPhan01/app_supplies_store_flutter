namespace Backend_ASP.NET.Models
{
    public class SuppliersModel
    {
        public Guid SupID { set; get; }
        public string? CompanyName { set; get; }// Tên công ty
        public string? ContactName { set; get; }//Tên người lên hệ
        public string? Address { set; get; }
        public string? City { set; get; }
        public string? PhoneNumber { set; get; }
        public string? Email { set; get; }
    }
}
