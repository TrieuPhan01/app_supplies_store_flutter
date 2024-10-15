using static Backend_ASP.NET.Models.MomoModel;

namespace Backend_ASP.NET.Repositories
{
    public interface IMomoRepository
    {
        Task<MomoPaymentResponse> CreatePaymentRequest(CreateMomoPaymentRequest request);
    }
}
