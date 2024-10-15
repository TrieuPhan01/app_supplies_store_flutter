using Backend_ASP.NET.Models;
using Newtonsoft.Json;
using static Backend_ASP.NET.Models.MomoModel;
using System.Security.Cryptography;
using System.Text;

namespace Backend_ASP.NET.Repositories
{
    public class MomoRepository : IMomoRepository
    {

        private const string Endpoint = "https://test-payment.momo.vn/v2/gateway/api/create";
        private const string IpnUrl = "https://6164-27-75-101-13.ngrok-free.app/api/Momo/momoipn";
        private const string AccessKey = "F8BBA842ECF85";
        private const string SecretKey = "K951B6PE1waDMi640xX08PD3vg6EkVlz";
        private const string PartnerCode = "MOMO";

        private readonly HttpClient _httpClient;

        public MomoRepository(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<MomoPaymentResponse> CreatePaymentRequest(CreateMomoPaymentRequest request)
        {
            var _requestId = Guid.NewGuid().ToString();
            var _orderId = Guid.NewGuid().ToString();
            var rawSignature = $"accessKey={AccessKey}&amount={request.Total}&extraData=&ipnUrl={IpnUrl}" +
                               $"&orderId={request.OrderID}&orderInfo={request.Id}&partnerCode={PartnerCode}" +
                               $"&redirectUrl=&requestId={_requestId}&requestType=captureWallet";

            var signature = ComputeHmacSha256(rawSignature, SecretKey);

            var paymentRequest = new
            {
                partnerCode = PartnerCode,
                partnerName = "Test",
                storeId = "MomoTestStore",
                requestId = _requestId,
                amount = Convert.ToInt64(request.Total),
                orderId = request.OrderID,
                orderInfo = request.Id,
                redirectUrl = "",
                ipnUrl = IpnUrl,
                lang = "vi",
                extraData = "",
                requestType = "captureWallet",
                signature = signature,
                orderExpireTime = 10
            };

            var content = new StringContent(JsonConvert.SerializeObject(paymentRequest), Encoding.UTF8, "application/json");
            var response = await _httpClient.PostAsync(Endpoint, content);

            if (response.IsSuccessStatusCode)
            {
                var responseContent = await response.Content.ReadAsStringAsync();
                return JsonConvert.DeserializeObject<MomoPaymentResponse>(responseContent);
            }

            throw new Exception("Invalid request method");
        }

        private string ComputeHmacSha256(string message, string secret)
        {
            var encoding = new ASCIIEncoding();
            byte[] keyByte = encoding.GetBytes(secret);
            byte[] messageBytes = encoding.GetBytes(message);
            using (var hmacsha256 = new HMACSHA256(keyByte))
            {
                byte[] hashmessage = hmacsha256.ComputeHash(messageBytes);
                return BitConverter.ToString(hashmessage).Replace("-", "").ToLower();
            }
        }
    }
}
