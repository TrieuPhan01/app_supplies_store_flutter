using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Repositories
{
    public class ProductsRepository : IProductsRepository
    {
        private readonly IMapper _mapper;
        private readonly MyAppDBConText _context;

        public ProductsRepository(MyAppDBConText context, IMapper mapper) 
        {
            _mapper = mapper;
            _context = context;
        }
        public async Task Add(ProductsModel product)
        {
            if (product == null)
            {
                throw new ArgumentNullException(nameof(product), "products cannot be null.");
            }
            var ProductEntity = _mapper.Map<Products>(product);
            await _context.Products.AddAsync(ProductEntity);
            await _context.SaveChangesAsync();
        }

        public async Task Delete(Guid id)
        {
            var _product = await _context.Products.FindAsync(id);
            if (_product == null)
            {
                throw new Exception("Emlpoyee not found.");
            }

            _context.Products.Remove(_product);
            await _context.SaveChangesAsync();
        }

        public async Task<List<ProductsModel>> GetAll()
        {
            var products = await _context.Products.ToListAsync();

            var productsModel = _mapper.Map<List<ProductsModel>>(products);

            return productsModel;
        }

        public async Task<ProductsModel> GetByID(Guid id)
        {
            var _product = await _context.Products.FindAsync(id);
            if (_product == null)
            {
                return null!;
            }
            var productModel = _mapper.Map<ProductsModel>(_product);
            return productModel;
        }

        public async Task<List<ProductsModel>> GetByCategoryID(Guid categoryId)
        {
            var _product = await _context.Products
           .Where(p => p.CategoryID == categoryId)
           .ToListAsync();

            if (_product == null || !_product.Any())
            {
                return null!;
            }
            var productModel = _mapper.Map<List<ProductsModel>>(_product);
            return productModel;
        }

        public async Task Update(ProductsModel product)
        {
            var _product = await _context.Products.FindAsync(product.ProductID);
            if (_product == null)
            {
                throw new Exception("Product not found.");
            }

            _mapper.Map(product, _product);

            await _context.SaveChangesAsync();
        }
    }
}
