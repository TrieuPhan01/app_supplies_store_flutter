using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Repositories
{
    public class CustomerRepository : ICustomerRepository
    {
        private readonly MyAppDBConText _context;

        public CustomerRepository(MyAppDBConText conText)
        {
            _context = conText;
        }

        public async Task Add(CustomerModel customer)
        {
            if (customer == null)
            {
                throw new ArgumentNullException(nameof(customer), "Customer cannot be null.");
            }

            var curentCus = new Custommers
            {
                CustommerId = customer.CustommerId,
                Age = customer.Age,
                Sex = customer.Sex,
                Address = customer.Address,
                Avatar = customer.Avatar,
                UserId = customer.UserId
            };

            await _context.Customs.AddAsync(curentCus);
            await _context.SaveChangesAsync();
        }

        public async Task Delete(Guid id)
        {
            var _customer = await _context.Customs.FindAsync(id);
            if (_customer == null)
            {
                throw new Exception("Customer not found.");
            }

            _context.Customs.Remove(_customer);
            await _context.SaveChangesAsync();
        }

        public async Task<List<CustomerModel>> GetAll()
        {
            var curenCustommer = await _context.Customs.ToListAsync();
            var cusModels = new List<CustomerModel>();

            if (curenCustommer != null)
            {
                foreach (var cus in curenCustommer)
                {
                    cusModels.Add(new CustomerModel
                    {
                        CustommerId = cus.CustommerId,
                        Age = cus.Age,
                        Sex = cus.Sex,
                        Address = cus.Address,
                        Avatar = cus.Avatar,
                        UserId = cus.UserId,
                    });
                }
            }
            return cusModels;
        }

        public async Task<CustomerModel> GetByID(Guid id)
        {
            var _customer = await _context.Customs.FindAsync(id);
            if (_customer == null)
            {
                throw new Exception("Customer not found.");
            }

            return new CustomerModel
            {
                CustommerId = _customer.CustommerId,
                Age = _customer.Age,
                Sex = _customer.Sex,
                Address = _customer.Address,
                Avatar = _customer.Avatar,
                UserId = _customer.UserId
            };
        }

        public async Task Update(CustomerModel model)
        {
            var _customer = await _context.Customs.FindAsync(model.CustommerId);
            if (_customer == null)
            {
                throw new Exception("Customer not found.");
            }

            _customer.Age = model.Age;
            _customer.Sex = model.Sex;
            _customer.Address = model.Address;
            _customer.Avatar = model.Avatar;
            _customer.UserId = model.UserId;

            await _context.SaveChangesAsync();
        }


    }
}
