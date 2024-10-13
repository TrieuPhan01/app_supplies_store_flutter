using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;
using System.Transactions;

namespace Backend_ASP.NET.Repositories
{
    public class PaymentRepository : IPaymentRepository
    {
        private readonly IMapper _mapper;
        private readonly MyAppDBConText _context;

        public PaymentRepository(MyAppDBConText context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }
        public async Task GetBillsByIdAndAmount(PaymentModel payment)
        {
            if (payment == null)
            {
                throw new ArgumentNullException(nameof(payment), "payment cannot be null.");
            }
            payment.ID = Guid.NewGuid();

            var PaymentEntity = _mapper.Map<Payment>(payment);
            await _context.Payments.AddAsync(PaymentEntity);
            await _context.SaveChangesAsync();
        }
        public Task UpdateBillStatus(IEnumerable<PaymentModel> bills, string orderId)
        {
            throw new NotImplementedException();
        }
    }
}
