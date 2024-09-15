using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface ICategoriesRepository
    {
        Task<List<CategoriesModel>> GetAll();
        Task<CategoriesModel> GetByID(Guid id);
        Task Update(CategoriesModel category);
        Task Add(CategoriesModel category);
        Task Delete(Guid id);
    }
}
