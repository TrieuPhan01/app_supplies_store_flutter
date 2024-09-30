using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Xml.Linq;

namespace Backend_ASP.NET.Repositories
{
    public class CategoriesRepository : ICategoriesRepository
    {
        private readonly MyAppDBConText _context;
        private readonly IMapper _mapper;

        public CategoriesRepository(MyAppDBConText conText, IMapper mapper) 
        { 
            _context = conText;
            _mapper = mapper;
        }

        public async Task Add(CategoriesModel category)
        {
            if (category == null)
            {
                throw new ArgumentNullException(nameof(category), "Customer cannot be null.");
            }
            var currentCat = _mapper.Map<Categories>(category);
            await _context.Categories.AddAsync(currentCat);
            await _context.SaveChangesAsync();
        }

        public async Task Delete(Guid id)
        {
            var _category = await _context.Categories.FindAsync(id);
            if (_category == null)
            {
                throw new Exception("Customer not found.");
            }

            _context.Categories.Remove(_category);
            await _context.SaveChangesAsync();
        }

        public async Task<List<CategoriesModel>> GetAll()
        {
            var currentCats = await _context.Categories.ToListAsync();
            if (currentCats == null)
            {
                throw new Exception("Customer not found.");
            }
            var catsModels = _mapper.Map<List<CategoriesModel>>(currentCats);
            return catsModels;
        }

        public async Task<CategoriesModel> GetByID(Guid id)
        {
            var _category = await _context.Categories.FindAsync(id);
            if (_category == null)
            {
                throw new Exception("Customer not found.");
            }
            var categoriesModel = _mapper.Map<CategoriesModel>(_category);
            return categoriesModel;
        }

        public async Task Update(CategoriesModel category)
        {
            var _category = await _context.Categories.FindAsync(category.CategoryID);
            if (_category == null)
            {
                throw new Exception("Customer not found.");
            }
            _mapper.Map(category, _category);
            await _context.SaveChangesAsync();
        }
    }
}
