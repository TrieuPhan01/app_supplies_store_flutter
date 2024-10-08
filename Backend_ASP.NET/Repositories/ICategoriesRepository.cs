using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface ICategoriesRepository
    {
        Task<List<CategoriesMPost>> GetAll();
        Task<CategoriesModel> GetByID(Guid id);
        Task Update(CategoriesModel category);
        Task Add(CategoriesMPost category);
        Task Delete(Guid id);
    }
}
