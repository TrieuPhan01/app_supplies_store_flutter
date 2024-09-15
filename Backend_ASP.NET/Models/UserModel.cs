using Backend_ASP.NET.Data;
using Backend_ASP.NET.Helpers;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Backend_ASP.NET.Models
{
    public class UserModel
    {
        public string? Id { get; set; }
        public string? UserName { get; set; }
       
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Avata { get; set; }
    }

    public class UserEditViewModel: UserModel
    {
        public string? PassWord { get; set; }
        public string? Roles { get; set; }
    }


}
