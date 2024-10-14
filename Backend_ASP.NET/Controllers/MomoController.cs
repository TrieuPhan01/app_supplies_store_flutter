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

        public MomoController(ILogger<MomoController> logger,IMomoRepository momoReposiotry, IPaymentRepository paymentRepository)
        {
            _momoRepository = momoReposiotry;
            _PaymentRepository = paymentRepository;
            _logger = logger;
        }

        [HttpPost("momoipn")]
        public async Task<IActionResult> MomoIpn([FromBody] JsonElement request)
        {
            Console.WriteLine("Kiêu dữ liệu"+ request.GetProperty("resultCode").ValueKind);
            Console.WriteLine("Kiêu dữ liệu" + request.GetProperty("amount").ValueKind);
            Console.WriteLine("Kiêu dữ liệu" + request.GetProperty("payType").ValueKind);
            Console.WriteLine("Kiêu dữ liệu" + request.GetProperty("transId").ValueKind);
            Console.WriteLine("Kiêu dữ liệu" + request.GetProperty("orderId").ValueKind);
            Console.WriteLine("Request data" + request);
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
                    var a = "1ca57fed-0c47-42d9-b421-b18b3b57d367";
                    PaymentModel payment = new PaymentModel
                    {
                        AmountPaid = amount,
                        PaymentMethod = paymentMethod,
                        TransactionCode = transactionCode,
                        //OrderID = orderId,
                        OrderID = Guid.Parse(a),
                        PaymentStatus = true
                    };
                    await _PaymentRepository.GetBillsByIdAndAmount(payment);
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
