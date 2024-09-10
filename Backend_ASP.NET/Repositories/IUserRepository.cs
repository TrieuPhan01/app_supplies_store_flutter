
using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Services
{
    public interface IUserRepository
    {
        Task<List<UserEditViewModel>> GetAll();
        Task<UserEditViewModel> GetByID(string id);
        void Update(UserEditViewModel User);
        void Delete(string id);
        string? GetUserRole(string id);
    }
}
