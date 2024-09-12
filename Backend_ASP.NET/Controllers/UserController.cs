using Backend_ASP.NET.Data;
using Backend_ASP.NET.Helpers;
using Backend_ASP.NET.Models;
using Backend_ASP.NET.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Backend_ASP.NET.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _userRepository;

        public UserController(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        [HttpGet]
        //[Authorize(Roles = AppRole.Customer)]
        public async Task<IActionResult> GetAll() 
        {
            try
            {
                var users = await _userRepository.GetAll(); 
                return Ok(users);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpGet("{id}")]
        //[Authorize(Roles = AppRole.Admin)]
        public async Task<IActionResult> GetByID(string id)
        {
            try
            {
                var data = await _userRepository.GetByID(id);
                if (data == null)
                {
                    return NotFound();
                }
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpPut("{id}")]
        public IActionResult Update(string id, UserEditViewModel user)
        {
            if (id != user.Id)
            {
                return BadRequest();
            }
            try
            {
                _userRepository.Update(user);
                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(string id)
        {
            try
            {
                _userRepository.Delete(id);
                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        //[HttpGet("GetRole/{id}")]
        //public IActionResult UserRole(string id)
        //{
        //    var roleName = _userRepository.GetUserRole(id);

        //    // Kiểm tra xem có tìm thấy role không
        //    if (roleName == null)
        //    {
        //        return NotFound(new { message = "User role not found" });
        //    }

        //    // Trả về tên role dưới dạng JSON
        //    return Ok(new { roleName = roleName });
        //}


    }
}
