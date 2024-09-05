using Microsoft.AspNetCore.Identity;

namespace Backend_ASP.NET.Data
{
    public enum UserRole
    {
        User,
        Staff,
        Admin
    }
    public class AppilcationUser : IdentityUser
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public UserRole UserRole { get; set; }
    }
}
