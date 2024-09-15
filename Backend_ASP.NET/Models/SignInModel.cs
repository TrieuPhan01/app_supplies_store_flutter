using System.ComponentModel.DataAnnotations;

namespace Backend_ASP.NET.Models
{
    public class SignInModel
    {
        [Required(ErrorMessage = "Phone number is required")]
        public string PhoneNumber { get; set; } = null!;

        [Required(ErrorMessage = "Password is required")]
        [DataType(DataType.Password)]
        public string Password { get; set; } = null!;
    }
}
