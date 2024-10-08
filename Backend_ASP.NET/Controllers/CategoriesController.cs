using Backend_ASP.NET.Data;
using Backend_ASP.NET.Helpers;
using Backend_ASP.NET.Models;
using Backend_ASP.NET.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Controllers
{
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : Controller
    {
        private readonly ICategoriesRepository _categoriesRepository;
        private readonly MyAppDBConText _context;

        public CategoriesController(ICategoriesRepository categoriesRepository, MyAppDBConText context) 
        {
            _categoriesRepository = categoriesRepository;
            _context = context;
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var categories = await _categoriesRepository.GetAll();
                return Ok(categories);
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
                var data = await _categoriesRepository.GetByID(id);
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
        [Authorize(Roles = AppRole.Admin)]
        public async Task<IActionResult> Add([FromBody] CategoriesMPost category)
        {
            try
            {
                if (category == null)
                {
                    return BadRequest("Category data is null.");
                }
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                category.CategoryID = Guid.NewGuid();
                await _categoriesRepository.Add(category);
                return CreatedAtAction(nameof(GetByID), new { id = category.CategoryID }, category);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
        [HttpGet("categoryProduct")]
        public async Task<ActionResult<IEnumerable<CategoriesModel>>> Get()
        {
            var categories = await _context.Categories
                .Include(c => c.Products)
                .ToListAsync();

            return Ok(categories);
        }

    }
}
