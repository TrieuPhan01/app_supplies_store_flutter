using Backend_ASP.NET.Models;
using Backend_ASP.NET.Repositories;
using Backend_ASP.NET.Services;
using Microsoft.AspNetCore.Mvc;

namespace Backend_ASP.NET.Controllers
{
    public class AccountsController: ControllerBase
    {
        private readonly IAccountRepository accountRepo;
        private readonly IUserRepository _userRepository;

        public AccountsController(IAccountRepository repo, IUserRepository userRepository) 
        {
            accountRepo = repo;
           _userRepository = userRepository;
        }
        [HttpPost("SignUp")]
        public async Task<IActionResult> SingUp(SignUpModel signUpModel)
        {
            var checkPhoneNumber = await _userRepository.GetByUserName(signUpModel.PhoneNumber);
            if (checkPhoneNumber is not null)
            {
                return Conflict("số điện thoại đã được đăng kí");
            }    
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
