using Microsoft.AspNetCore.Identity;

namespace Backend_ASP.NET.Data
{
    public enum UserRole
    {
        User ,
       Custommer,
       staff
    }
    public class Users : BaseModel
    {


        public string? UserName { get; set; }
        public string? PassWord { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public UserRole UserRole { get; set; }   
    }
}
