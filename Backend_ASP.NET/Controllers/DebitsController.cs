using Backend_ASP.NET.Data;
using Backend_ASP.NET.Helpers;
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
    public class DebitsController : Controller
    {
        private readonly IDebitsRepository _debitsRepository;

        public DebitsController(IDebitsRepository debitsRepository) 
        {
            _debitsRepository = debitsRepository;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var debits = await _debitsRepository.GetAll();
                return Ok(debits);
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
                var data = await _debitsRepository.GetByID(id);
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
        [Authorize(Roles = AppRole.Staff+","+ AppRole.Admin)]
        public async Task<IActionResult> Update(Guid id, DebitsModel model)
        {
            if (id != model.ID)
            {
                return BadRequest();
            }
            try
            {
                await _debitsRepository.Update(model);
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
                var current = await _debitsRepository.GetByID(id);
                if (current == null)
                {
                    return NotFound("Debit not found");
                }

                await _debitsRepository.Delete(id);
                return Ok("Debit deleted successfully");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("Create")]
        public async Task<IActionResult> Add([FromBody] DebitsModel debit)
        {
            try
            {
                if (debit == null)
                {
                    return BadRequest("Debit data is null.");
                }
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                debit.ID = Guid.NewGuid();
                await _debitsRepository.Add(debit);
                return CreatedAtAction(nameof(GetByID), new { id = debit.ID }, debit);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
