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
    public class SuppliersController : Controller
    {
        private readonly ISuppliersRepository _suppliersRepository;

        public SuppliersController(ISuppliersRepository suppliersRepository) 
        {
            _suppliersRepository = suppliersRepository;
        }


        [HttpGet("All")]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var suppliers = await _suppliersRepository.GetAll();
                return Ok(suppliers);
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
                var data = await _suppliersRepository.GetByID(id);
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

        [HttpPost("Create")]
        public async Task<IActionResult> Add([FromBody] SuppliersModel supplier, Guid storeId)
        {
            try
            {
                if (supplier == null)
                {
                    return BadRequest("Supplier data is null.");
                }
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

               
                supplier.SupID = Guid.NewGuid();

                await _suppliersRepository.Add(supplier, storeId);
                return CreatedAtAction(nameof(GetByID), new { id = supplier.SupID }, supplier);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
