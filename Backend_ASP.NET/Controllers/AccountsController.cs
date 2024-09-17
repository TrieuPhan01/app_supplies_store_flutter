using Backend_ASP.NET.Models;
using Backend_ASP.NET.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace Backend_ASP.NET.Controllers
{
    public class AccountsController: ControllerBase
    {
        private readonly IAccountRepository accountRepo;

        public AccountsController(IAccountRepository repo) 
        {
            accountRepo = repo;
        }
        [HttpPost("SignUp")]
        public async Task<IActionResult> SingUp(SignUpModel signUpModel)
        {
            var result = await accountRepo.SingUpAsync(signUpModel);
            if (result.Succeeded) 
            {
                return Ok(result.Succeeded);
            }
            return StatusCode(500);
        }


        [HttpPost("SignIn")]
        public async Task<IActionResult> SignIn(SignInModel signInModel)
        {
            var result = await accountRepo.SingInAsync(signInModel);
            if(string.IsNullOrEmpty(result))
            {
                return BadRequest();
            }
            return Ok(result);
        }

    }
}
