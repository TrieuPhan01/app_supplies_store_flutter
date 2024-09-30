using Backend_ASP.NET.Models;
using Microsoft.AspNetCore.Identity;

namespace Backend_ASP.NET.Repositories
{
    public interface IAccountRepository
    {
        public Task<IdentityResult> SingUpAsync(SignUpModel model);
        public Task<String> SingInAsync(SignInModel model);
    }
}
