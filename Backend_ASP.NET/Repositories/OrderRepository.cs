using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Repositories
{
    public class OrderRepository : IOrderRepository
    {
        private readonly MyAppDBConText _context;
        private readonly IMapper _mapper;

        public OrderRepository(MyAppDBConText context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task CreateOrderAsync(OrderModel order)
        {
            if (order == null)
            {
                throw new ArgumentNullException(nameof(order), "order cannot be null.");
            }
            var orderEmp = _mapper.Map<Orders>(order);
            await _context.Orders.AddAsync(orderEmp);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteOrderAsync(Guid id)
        {
            var _order = await _context.Orders.FindAsync(id);
            if (_order == null)
            {
                throw new Exception("Emlpoyee not found.");
            }

            _context.Orders.Remove(_order);
            await _context.SaveChangesAsync();
        }

        public async Task<IEnumerable<OrderModel>> GetAllOrdersAsync()
        {
            var _order = await _context.Orders.ToListAsync();

            var _orderModel = _mapper.Map<List<OrderModel>>(_order);

            return _orderModel;
        }

        public async Task<OrderModel> GetOrderByIdAsync(Guid id)
        {
            var _order = await _context.Orders.FindAsync(id);
            if (_order == null)
            {
                return null!;
            }
            var _orderModel = _mapper.Map<OrderModel>(_order);
            return _orderModel;
        }

        public async Task UpdateOrderAsync(OrderModel order)
        {
            var _order = await _context.Orders.FindAsync(order.Id);
            if (_order == null)
            {
                throw new Exception("Employee not found.");
            }

            _mapper.Map(order, _order);

            await _context.SaveChangesAsync();
        }
    }
}
