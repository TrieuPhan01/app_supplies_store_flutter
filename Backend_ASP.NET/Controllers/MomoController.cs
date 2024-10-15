namespace Backend_ASP.NET.Controllers
{
    using System;
    using System.Security.Cryptography;
    using System.Text;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Newtonsoft.Json;
    using System.Net.Http;
    using Backend_ASP.NET.Repositories;
    using static Backend_ASP.NET.Models.MomoModel;
    using System.Text.Json;
    using Backend_ASP.NET.Models;
    using System.Transactions;

    [ApiController]
    [Route("api/[controller]")]
    public class MomoController : ControllerBase
    {
        private readonly IMomoRepository _momoRepository;
        private readonly IPaymentRepository _PaymentRepository;
        private readonly ILogger<MomoController> _logger;
        private readonly IOrderRepository _orderRepository;

        public MomoController(IOrderRepository orderRepository, ILogger<MomoController> logger,IMomoRepository momoReposiotry, IPaymentRepository paymentRepository)
        {
            _momoRepository = momoReposiotry;
            _PaymentRepository = paymentRepository;
            _logger = logger;
            _orderRepository = orderRepository;
        }

        [HttpPost("momoipn")]
        public async Task<IActionResult> MomoIpn([FromBody] JsonElement request)
        {
            try
            {
                var resultCode = request.GetProperty("resultCode").GetInt32(); 
                var amount = request.GetProperty("amount").GetInt32(); 
                var paymentMethod = request.GetProperty("payType").GetString();
                var transIdNumber = request.GetProperty("transId").GetInt64();
                var transactionCode = transIdNumber.ToString();
                var orderId = request.GetProperty("orderId").GetGuid();

                if (resultCode == 0)
                {
                    
                    PaymentModel payment = new PaymentModel
                    {
                        AmountPaid = amount,
                        PaymentMethod = paymentMethod,
                        TransactionCode = transactionCode,
                        OrderID = orderId,
                        
                        PaymentStatus = true
                    };

                    await _PaymentRepository.GetBillsByIdAndAmount(payment);
                    await _orderRepository.PatchOrderStatus(orderId);
                    return Ok(new { message = "Payment created successfully." });
                }
                else
                {
                    return BadRequest(new { message = "Payment failed." });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error processing Momo IPN");
                return StatusCode(500, new { message = "Internal server error" });
            }
        }
        [HttpPost("create")]
        public async Task<IActionResult> CreateMomoPayment([FromBody] CreateMomoPaymentRequest request)
        {
            Console.WriteLine("Momo Callback Data: adadadasasdasda" );
            try
            {
                var response = await _momoRepository.CreatePaymentRequest(request);
                return Ok(response);
            }
            catch (Exception e)
            {
                return StatusCode(500, new { error = e.Message });
            }
        }
    }
}
