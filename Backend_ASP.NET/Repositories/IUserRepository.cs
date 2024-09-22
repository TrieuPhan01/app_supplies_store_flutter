
using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Services
{
    public interface IUserRepository
    {
        Task<List<UserEditViewModel>> GetAll();
        Task<UserEditViewModel> GetByID(string id);
        Task Update(UserEditViewModel user);
        Task Delete(string id);
        Task<string?> GetUserRole(string id);
     
    }
}
