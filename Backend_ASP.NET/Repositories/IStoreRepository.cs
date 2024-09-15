using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface IStoreRepository
    {
        Task<List<StoreModel>> GetAll();
        Task<StoreModel> GetByID(Guid id);
        Task Add(StoreModel store);

    }
}
