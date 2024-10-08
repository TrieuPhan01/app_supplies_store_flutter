using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface IProductsRepository
    {
        Task<List<ProductsModel>> GetAll();
        Task<ProductsModel> GetByID(Guid id);
        Task Update(ProductsModel products);
        Task Add(ProductsModel products);
        Task Delete(Guid id);
        Task<List<ProductsModel>> GetByCategoryID(Guid categoryId);
    }
}
