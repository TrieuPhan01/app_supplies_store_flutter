using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace Backend_ASP.NET.Repositories
{
    public class CustomerRepository : ICustomerRepository
    {
        private readonly MyAppDBConText _context;
        private readonly IMapper _mapper;

        public CustomerRepository(MyAppDBConText conText, IMapper mapper)
        {
            _context = conText;
            _mapper = mapper;
        }

        public async Task Add(CustomerModel customer, Guid storeID)
        {
            if (customer == null)
            {
                throw new ArgumentNullException(nameof(customer), "Customer cannot be null.");
            }
            var curentCus = _mapper.Map<Custommers>(customer);
            await _context.Customs.AddAsync(curentCus);
            await _context.SaveChangesAsync();
            var storeCustomers = new StoreCustomer
            {
                CustommerID = curentCus.CustommerId,  
                StoreID = storeID,                        
            };

            await _context.StoreCustomer.AddAsync(storeCustomers);
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
            if (curenCustommer == null)
            {
                throw new Exception("Customer not found.");
            }
            var customerModels = _mapper.Map<List<CustomerModel>>(curenCustommer);
            return customerModels;
        }

        public async Task<CustomerModel> GetByID(Guid id)
        {
            var _customer = await _context.Customs.FindAsync(id);
            if (_customer == null)
            {
                throw new Exception("Customer not found.");
            }
            var customerModel = _mapper.Map<CustomerModel>(_customer);
            return customerModel;
        }

        public async Task Update(CustomerModel model)
        {
            var _customer = await _context.Customs.FindAsync(model.CustommerId);
            if (_customer == null)
            {
                throw new Exception("Customer not found.");
            }
            _mapper.Map(model, _customer);
            await _context.SaveChangesAsync();
        }

        public async Task<CustomerModel> GetByUserID(string userId)
        {
            var customer = await _context.Customs.FirstOrDefaultAsync(c => c.UserId == userId);
            if (customer == null)
            {
                return null;
            }
            return _mapper.Map<CustomerModel>(customer);
        }
    }
}
