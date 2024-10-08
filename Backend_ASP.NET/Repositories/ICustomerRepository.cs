﻿using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Repositories
{
    public interface ICustomerRepository
    {
        Task<List<CustomerModel>> GetAll();
        Task<CustomerModel> GetByID(Guid id);
        Task Update(CustomerModel customer);
        Task Add(CustomerModel customer, Guid storeID);
        Task Delete(Guid id);
        Task<CustomerModel> GetByUserID(string userId);
    }
} 
