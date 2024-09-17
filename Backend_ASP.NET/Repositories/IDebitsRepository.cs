using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface IDebitsRepository
    {
        Task<List<DebitsModel>> GetAll();
        Task<DebitsModel> GetByID(Guid id);
        Task Update(DebitsModel debits);
        Task Add(DebitsModel DebitsModel);
        Task Delete(Guid id);
    }
}
