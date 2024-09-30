using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Backend_ASP.NET.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Backend_ASP.NET.Controllers
{
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeesController : Controller
    {
        private readonly IEmployeeRepository _employeeRepository;
        public EmployeesController(IEmployeeRepository employeeRepository)
        {
            _employeeRepository = employeeRepository;
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var employees = await _employeeRepository.GetAll();
                return Ok(employees);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpGet("GetByID/{id}")]
        public async Task<IActionResult> GetByID(Guid id)
        {
            try
            {
                var data = await _employeeRepository.GetByID(id);
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


        [HttpPut("Update/{id}")]
        public async Task<IActionResult> Update(Guid id, EmployeesModel model)
        {
            if (id != model.EmployeeId)
            {
                return BadRequest();
            }
            try
            {
                await _employeeRepository.Update(model);
                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpDelete("Delete/{id}")]
        public async Task<IActionResult> Delete(Guid id)
        {
            try
            {
                var employee = await _employeeRepository.GetByID(id);
                if (employee == null)
                {
                    return NotFound("Customer not found");
                }

                await _employeeRepository.Delete(id);
                return Ok("Customer deleted successfully");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("Create")]
        public async Task<IActionResult> Add([FromBody] EmployeesModel employee)
        {
            try
            {
                if (employee == null)
                {
                    return BadRequest("Employee data is null.");
                }
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var existingUser = await _employeeRepository.GetByUserID(employee.UserId);
                if (existingUser != null)
                {
                    return BadRequest("User ID already associated with another customer.");
                }
                employee.EmployeeId = Guid.NewGuid();
                await _employeeRepository.Add(employee);
                return CreatedAtAction(nameof(GetByID), new { id = employee.EmployeeId }, employee);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
