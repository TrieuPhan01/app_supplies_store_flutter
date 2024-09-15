using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;
using System.Xml.Linq;

namespace Backend_ASP.NET.Repositories
{
    public class CategoriesRepository : ICategoriesRepository
    {
        private readonly MyAppDBConText _context;

        public CategoriesRepository(MyAppDBConText conText) 
        { 
            _context = conText;
        }

        public async Task Add(CategoriesModel category)
        {
            if (category == null)
            {
                throw new ArgumentNullException(nameof(category), "Customer cannot be null.");
            }

            var currentCat = new Categories
            {
                CategoryID = category.CategoryID,
                Name = category.Name,
                Unit = category.Unit,
                Note = category.Note,
            };

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
            var catsModels = new List<CategoriesModel>();

            if (currentCats != null)
            {
                foreach (var cus in currentCats)
                {
                    catsModels.Add(new CategoriesModel
                    {
                        CategoryID = cus.CategoryID,
                        Name = cus.Name,
                        Unit = cus.Unit,
                        Note = cus.Note,
                    });
                }
            }
            return catsModels;
        }

        public async Task<CategoriesModel> GetByID(Guid id)
        {
            var _category = await _context.Categories.FindAsync(id);
            if (_category == null)
            {
                throw new Exception("Customer not found.");
            }

            return new CategoriesModel
            {
                CategoryID = _category.CategoryID,
                Name = _category.Name,
                Unit = _category.Unit,
                Note = _category.Note,
            };
        }

        public async Task Update(CategoriesModel category)
        {
            var _category = await _context.Categories.FindAsync(category.CategoryID);
            if (_category == null)
            {
                throw new Exception("Customer not found.");
            }

            _category.CategoryID = _category.CategoryID;
            _category.Name = _category.Name;
            _category.Unit = _category.Unit;
            _category.Note = _category.Note;

            await _context.SaveChangesAsync();
        }
    }
}
