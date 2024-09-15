using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.CodeAnalysis.Elfie.Diagnostics;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Repositories
{
    public class EmployeesRepository : IEmployeeRepository
    {
        private readonly MyAppDBConText _context;

        public EmployeesRepository(MyAppDBConText context) 
        { 
            _context = context;
        }
        public async Task Add(EmployeesModel employees)
        {
            if (employees == null)
            {
                throw new ArgumentNullException(nameof(employees), "employees cannot be null.");
            }

            var curentEmp = new Employee
            {
                EmployeeId = employees.EmployeeId,
                HireDate = employees.HireDate,
                Salary = employees.Salary,
                Position = employees.Position,
                Status = employees.Status,
                UserId = employees.UserId,
                StoreID = employees.StoreID,
            };

            await _context.Employees.AddAsync(curentEmp);
            await _context.SaveChangesAsync();
        }

        public async Task Delete(Guid id)
        {
            var _employee = await _context.Employees.FindAsync(id);
            if (_employee == null)
            {
                throw new Exception("Emlpoyee not found.");
            }

            _context.Employees.Remove(_employee);
            await _context.SaveChangesAsync();
        }

        public async Task<List<EmployeesModel>> GetAll()
        {
            var employee = await _context.Employees.ToListAsync();
            var cusEmp = new List<EmployeesModel>();

            if (employee != null)
            {
                foreach (var emp in employee)
                {
                    cusEmp.Add(new EmployeesModel
                    {
                        EmployeeId = emp.EmployeeId,
                        HireDate = emp.HireDate,
                        Salary = emp.Salary,
                        Position = emp.Position,
                        Status = emp.Status,
                        UserId = emp.UserId,
                        StoreID = emp.StoreID
                    });
                }
            }
            return cusEmp;
        }

        public async Task<EmployeesModel> GetByID(Guid id)
        {
            var _employee = await _context.Employees.FindAsync(id);
            if (_employee == null)
            {
                throw new Exception("Customer not found.");
            }

            return new EmployeesModel
            {
                EmployeeId = _employee.EmployeeId,
                HireDate = _employee.HireDate,
                Salary = _employee.Salary,
                Position = _employee.Position,
                Status = _employee.Status,
                UserId = _employee.UserId,
                StoreID = _employee.StoreID
            };
        }

        public async Task Update(EmployeesModel employees)
        {
            var _employee = await _context.Employees.FindAsync(employees.EmployeeId);
            if (_employee == null)
            {
                throw new Exception("Employee not found.");
            }

            _employee.EmployeeId = employees.EmployeeId;
            _employee.HireDate = employees.HireDate;
            _employee.Salary = employees.Salary;
            _employee.Position = employees.Position;
            _employee.Status = employees.Status;
            _employee.UserId = employees.UserId;
            _employee.StoreID = employees.StoreID;

            await _context.SaveChangesAsync();
        }
    }
}
