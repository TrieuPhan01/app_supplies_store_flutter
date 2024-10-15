using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface IOrderDetailRepository
    {
        Task<List<OrderDetailsModel>> GetAllOrderDetailsAsync();
        Task<OrderDetailsModel> GetOrderDetailByIdAsync(Guid id);
        Task CreateOrderDetailAsync(OrderDetailsModel orderDetail);
        Task UpdateOrderDetailAsync(OrderDetailsModel orderDetail);
        Task DeleteOrderDetailAsync(Guid id);
        //Task CreateOrderWithDetails(OrderDetailsModel orderDetail);
    }
}
