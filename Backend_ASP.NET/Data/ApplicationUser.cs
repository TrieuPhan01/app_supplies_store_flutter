using Microsoft.AspNetCore.Identity;

namespace Backend_ASP.NET.Data
{
    
    public class ApplicationUser : IdentityUser
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public virtual ICollection<ApplicationUserRole>? UserRoles { get; set; }
    }
    public class ApplicationRole : IdentityRole
    {
        public string? RoleName { get; set; }
        public virtual ICollection<ApplicationUserRole>? UserRoles { get; set; }
    }
    public class ApplicationUserRole : IdentityUserRole<string>
    {
        public virtual ApplicationUser? User { get; set; }
        public virtual ApplicationRole? Role { get; set; }
    }
}
