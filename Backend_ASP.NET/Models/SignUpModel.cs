using System.ComponentModel.DataAnnotations;

namespace Backend_ASP.NET.Models
{
    public class SignUpModel
    {

        [Required]
        public string FirstName { get; set; } = null!;
        [Required]
        public string LastName { get;set; } = null!;
        [Required, EmailAddress]
        public string PhoneNumber { get; set; } = null!;
        [Required]
        public string Password { get; set; } = null!;
        [Required]
        public string ConfirmPassword { get; set; } = null!;

    }
}
