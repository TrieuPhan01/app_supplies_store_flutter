using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface IPaymentRepository
    {
        Task GetBillsByIdAndAmount(PaymentModel payment);
        Task UpdateBillStatus(IEnumerable<PaymentModel> bills, string orderId);
    }
}
