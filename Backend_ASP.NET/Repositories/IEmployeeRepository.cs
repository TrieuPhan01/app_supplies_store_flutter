using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface IEmployeeRepository
    {
        Task<List<EmployeesModel>> GetAll();
        Task<EmployeesModel> GetByID(Guid id);
        Task Update(EmployeesModel employees);
        Task Add(EmployeesModel employees);
        Task Delete(Guid id);
    }
}
