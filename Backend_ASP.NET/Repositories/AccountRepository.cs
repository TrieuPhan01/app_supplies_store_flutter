using Backend_ASP.NET.Data;
using Backend_ASP.NET.Helpers;
using Backend_ASP.NET.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Backend_ASP.NET.Repositories
{
    public class AccountRepository : IAccountRepository

    {
        private readonly UserManager<ApplicationUser> userManager;
        private readonly SignInManager<ApplicationUser> signInManager;
        private readonly IConfiguration configuration;
        private readonly RoleManager<IdentityRole> roleManager;

        public AccountRepository(UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager, IConfiguration configuration, RoleManager<IdentityRole> roleManager) 
        { 
            this.userManager = userManager;
            this.signInManager = signInManager; 
            this.configuration = configuration;
            this.roleManager = roleManager;
        }
        public async Task<string> SingInAsync(SignInModel model)
        {
            var user = await userManager.Users.FirstOrDefaultAsync(u => u.PhoneNumber == model.PhoneNumber);
            Boolean passwordValid = await userManager.CheckPasswordAsync(user, model.Password);// Tra ve kieu True/False
            if (user == null || !passwordValid)
            {
                return string.Empty;
            }
            var authClaims = new List<Claim>
            {
                new Claim(ClaimTypes.MobilePhone, model.PhoneNumber),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var userRole = await userManager.GetRolesAsync(user);
            foreach (var role in userRole) 
            {
                authClaims.Add(new Claim(ClaimTypes.Role, role.ToString()));
            }

            var authenkey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["JWT:Secret"]));
            var token = new JwtSecurityToken(
                issuer: configuration["JWT:ValidIssuer"],
                audience: configuration["JWT:ValidAudience"],
                expires: DateTime.Now.AddMinutes(20),//Thoi gian Token het han
                claims: authClaims,
                signingCredentials: new SigningCredentials(authenkey, SecurityAlgorithms.HmacSha256Signature)//Ma hoa
                );
            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public async Task<IdentityResult> SingUpAsync(SignUpModel model)
        {
            var _user = new ApplicationUser
            {
                FirstName = model.FirstName,
                LastName = model.LastName,
                Email = model.Email,
                PhoneNumber =model.PhoneNumber,
                UserName = model.PhoneNumber,
                
            };       
            var result = await userManager.CreateAsync(_user, model.Password);
            if (result.Succeeded) 
            { 
                if(!await roleManager.RoleExistsAsync(AppRole.Customer))
                {
                    await roleManager.CreateAsync(new IdentityRole(AppRole.Customer));
                }
                await userManager.AddToRoleAsync(_user, AppRole.Customer);
            }

            return result;

        }
    }
}
