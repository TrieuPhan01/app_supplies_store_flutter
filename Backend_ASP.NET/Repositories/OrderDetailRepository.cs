using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Repositories
{
    public class OrderDetailRepository : IOrderDetailRepository
    {
        private readonly MyAppDBConText _context;
        private readonly IMapper _mapper;

        public OrderDetailRepository(MyAppDBConText context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task CreateOrderDetailAsync(OrderDetailsModel orderDetail)
        {
            if (orderDetail == null)
            {
                throw new ArgumentNullException(nameof(orderDetail), "orderDetail cannot be null.");
            }
            var orderEmp = _mapper.Map<OrderDetails>(orderDetail);
            await _context.OrderDetails.AddAsync(orderEmp);

            await _context.SaveChangesAsync();
        }

        public async Task DeleteOrderDetailAsync(Guid id)
        {
            var _orderDetail = await _context.OrderDetails.FindAsync(id);
            if (_orderDetail == null)
            {
                throw new Exception("OrderDetail not found.");
            }

            _context.OrderDetails.Remove(_orderDetail);
            await _context.SaveChangesAsync();
        }

        public async Task<List<OrderDetailsModel>> GetAllOrderDetailsAsync()
        {
            var _orderDetail = await _context.OrderDetails.ToListAsync();

            var _orderDetailModel = _mapper.Map<List<OrderDetailsModel>>(_orderDetail);

            return _orderDetailModel;
        }

        public async Task<OrderDetailsModel> GetOrderDetailByIdAsync(Guid id)
        {
            var _orderDetail = await _context.OrderDetails.FindAsync(id);
            if (_orderDetail == null)
            {
                return null!;
            }
            var _orderDetailModel = _mapper.Map<OrderDetailsModel>(_orderDetail);
            return _orderDetailModel;
        }

        public async Task UpdateOrderDetailAsync(OrderDetailsModel orderDetail)
        {
            var _orderDetail = await _context.OrderDetails.FindAsync(orderDetail.ID);
            if (_orderDetail == null)
            {
                throw new Exception("OrderDetail not found.");
            }

            _mapper.Map(orderDetail, _orderDetail);

            await _context.SaveChangesAsync();
        }
    }
}
