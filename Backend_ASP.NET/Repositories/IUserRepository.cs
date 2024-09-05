
using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Services
{
    public interface IUserRepository
    {
        List<UserModel> GetAll();
        UserModel GetByID(string id);
        UserModel Add(UserModel User);
        void Update(UserUpdate User);
        void Delete(string id);
    }
}
