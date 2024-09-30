using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Backend_ASP.NET.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Backend_ASP.NET.Controllers
{
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    [ApiController]
    public class CustomersController : ControllerBase
    {
        private readonly ICustomerRepository _customerRepository;

        public CustomersController(ICustomerRepository customerRepository) 
        {
            _customerRepository = customerRepository;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var customer = await _customerRepository.GetAll();
                return Ok(customer);
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
                var data = await _customerRepository.GetByID(id);
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
        public async Task<IActionResult> Update(Guid id, CustomerModel model)
        {
            if (id != model.CustommerId)
            {
                return BadRequest();
            }
            try
            {
                await _customerRepository.Update(model);
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
                var current = await _customerRepository.GetByID(id);
                if (current == null)
                {
                    return NotFound("Customer not found");
                }

                await _customerRepository.Delete(id);
                return Ok("Customer deleted successfully");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("Create")]
        public async Task<IActionResult> Add([FromBody] CustomerModel customer, Guid storeID)
        {
            try
            {
                if (customer == null)
                {
                    return BadRequest("Customer data is null.");
                }
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                var existingUser = await _customerRepository.GetByUserID(customer.UserId);
                if (existingUser != null)
                {
                    return BadRequest("User ID already associated with another customer.");
                }
                customer.CustommerId = Guid.NewGuid();

                await _customerRepository.Add(customer, storeID);
                return CreatedAtAction(nameof(GetByID), new { id = customer.CustommerId }, customer);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }


    }
}
