using System.ComponentModel.DataAnnotations;

namespace Backend_ASP.NET.Models
{
    public class SignInModel
    {
        [Required, Phone]
        public string PhoneNumber { get; set; } = null!;
        [Required]
        public string Password { get; set; } = null!;
    }
}
