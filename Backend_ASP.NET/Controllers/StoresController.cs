using Backend_ASP.NET.Models;
using Backend_ASP.NET.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace Backend_ASP.NET.Controllers
{
    public class StoresController : Controller
    {
        private readonly IStoreRepository _storeRepository;

        public StoresController(IStoreRepository storeRepository) 
        {
            _storeRepository = storeRepository;
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var store = await _storeRepository.GetAll();
                return Ok(store);
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
                var data = await _storeRepository.GetByID(id);
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
        public async Task<IActionResult> Add([FromBody] StoreModel store)
        {
            try
            {
                if (store == null)
                {
                    return BadRequest("Customer data is null.");
                }
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                await _storeRepository.Add(store);
                return CreatedAtAction(nameof(GetByID), new { id = store.StoreID }, store);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
