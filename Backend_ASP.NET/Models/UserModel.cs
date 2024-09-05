using Backend_ASP.NET.Data;

namespace Backend_ASP.NET.Models
{
    public class UserModel
    {    
        public string? UserName { get; set; }
        public string? PassWord { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public UserRole UserRole { get; set; }
    }

    public class UserUpdate: UserModel
    {
        public string? Id { get; set; }
    }
}
