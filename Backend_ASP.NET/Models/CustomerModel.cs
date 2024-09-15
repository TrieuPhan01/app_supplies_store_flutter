using Backend_ASP.NET.Data;

namespace Backend_ASP.NET.Models
{
    public class CustomerModel
    {
        public Guid CustommerId { get; set; }
        public int? Age { get; set; }
        public sexEnum? Sex { get; set; }
        public String? Address { get; set; }
        public String? Avatar { get; set; }
        //Relationship
        public string? UserId { get; set; }
    }
}
