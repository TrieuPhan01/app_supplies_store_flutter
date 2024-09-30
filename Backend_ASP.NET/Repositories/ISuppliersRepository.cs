using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface ISuppliersRepository
    {
        Task<List<SuppliersModel>> GetAll();
        Task<SuppliersModel> GetByID(Guid id);
        Task Update(SuppliersModel suppliers);
        Task Add(SuppliersModel suppliers, Guid storeID);
        Task Delete(Guid id);
    }
}
