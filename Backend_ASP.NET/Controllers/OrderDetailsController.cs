using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Backend_ASP.NET.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace Backend_ASP.NET.Controllers
{
    public class OrderDetailsController : Controller
    {
        private readonly MyAppDBConText _context;
        private readonly IOrderDetailRepository _orderDetailRepository;

        public OrderDetailsController(IOrderDetailRepository orderDetailRepository, MyAppDBConText context)
        {
            _context = context;
            _orderDetailRepository = orderDetailRepository;
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var orderDetail = await _orderDetailRepository.GetAllOrderDetailsAsync();
                return Ok(orderDetail);
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
                var data = await _orderDetailRepository.GetOrderDetailByIdAsync(id);
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
        public async Task<IActionResult> Add([FromBody] OrderDetailsModel orderDetail)
        {
            try
            {
                if (orderDetail == null)
                {
                    return BadRequest("order data is null.");
                }
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                orderDetail.ID = Guid.NewGuid();
                await _orderDetailRepository.CreateOrderDetailAsync(orderDetail);
                return CreatedAtAction(nameof(GetByID), new { id = orderDetail.ID }, orderDetail);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }


}
