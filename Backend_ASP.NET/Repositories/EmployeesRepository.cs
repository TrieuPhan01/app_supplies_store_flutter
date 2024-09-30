using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.CodeAnalysis.Elfie.Diagnostics;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Repositories
{
    public class EmployeesRepository : IEmployeeRepository
    {
        private readonly MyAppDBConText _context;
        private readonly IMapper _mapper;

        public EmployeesRepository(MyAppDBConText context, IMapper mapper) 
        { 
            _context = context;
            _mapper = mapper;
        }
        public async Task Add(EmployeesModel employees)
        {
            if (employees == null)
            {
                throw new ArgumentNullException(nameof(employees), "employees cannot be null.");
            }
            var curentEmp = _mapper.Map<Employee>(employees);
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
            var employees = await _context.Employees.ToListAsync();

            var employeesModel = _mapper.Map<List<EmployeesModel>>(employees);

            return employeesModel;
        }

        public async Task<EmployeesModel> GetByID(Guid id)
        {
            var _employee = await _context.Employees.FindAsync(id);
            if (_employee == null)
            {
                return null!;
            }
            var employeeModel = _mapper.Map<EmployeesModel>(_employee);
            return employeeModel;
        }

        public async Task Update(EmployeesModel employees)
        {
            var _employee = await _context.Employees.FindAsync(employees.EmployeeId);
            if (_employee == null)
            {
                throw new Exception("Employee not found.");
            }

            _mapper.Map(employees, _employee);

            await _context.SaveChangesAsync();
        }

        public async Task<EmployeesModel> GetByUserID(string userId)
        {
            var employee = await _context.Employees.FirstOrDefaultAsync(c => c.UserId == userId);
            return _mapper.Map<EmployeesModel>(employee);
        }
    }
}
