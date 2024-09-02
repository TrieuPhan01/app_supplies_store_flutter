using Backend_ASP.NET.Data;

namespace Backend_ASP.NET.Models
{
    public class CustommerModel
    {
        public String? FirstName { get; set; }
        public String? LastName { get; set; }
        public int? Age { get; set; }
        public sexEnum? Sex { get; set; }
        public String? Address { get; set; }
        public String? Email { get; set; }
        public String? PhoneNumber { get; set; }
        public String? Avatar { get; set; }
    }
}
