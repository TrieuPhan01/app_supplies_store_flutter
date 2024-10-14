using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface IOrderRepository
    {
        Task<IEnumerable<OrderModel>> GetAllOrdersAsync();
        Task<OrderModel> GetOrderByIdAsync(Guid id);
        Task CreateOrderAsync(OrderModel order);
        Task UpdateOrderAsync(OrderModel order);
        Task DeleteOrderAsync(Guid id);
        Task PatchOrderStatus(Guid id);
    }
}
