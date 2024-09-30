using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Repositories
{
    public class SuppliersRepository : ISuppliersRepository
    {
        private readonly MyAppDBConText _context;
        private readonly IMapper _mapper;

        public SuppliersRepository(MyAppDBConText conText, IMapper mapper)
        {
            _context = conText;
            _mapper = mapper;
        }
        public async Task Add(SuppliersModel suppliers, Guid storeID)
        {
            if (suppliers == null)
            {
                throw new ArgumentNullException(nameof(suppliers), "Suppliers cannot be null.");
            }

            var curentSuppliers = _mapper.Map<Suppliers>(suppliers);

            await _context.Suppliers.AddAsync(curentSuppliers);
            await _context.SaveChangesAsync();

            // Sau khi lưu Supplier, lấy SupplierID để lưu vào bảng StoresSuppliers
            var storeSupplier = new StoresSuppliers
            {
                SupplierID = curentSuppliers.SupID,  
                StoreID = storeID               
            };

            await _context.StoresSuppliers.AddAsync(storeSupplier);
            await _context.SaveChangesAsync();
        }

        public async Task Delete(Guid id)
        {
            var _supplier = await _context.Suppliers.FindAsync(id);
            if (_supplier == null)
            {
                throw new Exception("Debit not found.");
            }

            _context.Suppliers.Remove(_supplier);
            await _context.SaveChangesAsync();
        }

        public async Task<List<SuppliersModel>> GetAll()
        {
            var allSuppliers = await _context.Suppliers.ToListAsync();
            if (allSuppliers == null)
            {
                throw new Exception("Suppliers not found.");
            }
            var SupplierModels = _mapper.Map<List<SuppliersModel>>(allSuppliers);
            return SupplierModels;
        }

        public async Task<SuppliersModel> GetByID(Guid id)
        {
            var _suppliers = await _context.Suppliers.FindAsync(id);
            if (_suppliers == null)
            {
                throw new Exception("Debit not found.");
            }
            var supplierModel = _mapper.Map<SuppliersModel>(_suppliers);
            return supplierModel;
        }

        public async Task Update(SuppliersModel suppliers)
        {
            var _currentSupplier = await _context.Suppliers.FindAsync(suppliers.SupID);
            if (_currentSupplier == null)
            {
                throw new Exception("Debit not found.");
            }
            _mapper.Map(suppliers, _currentSupplier);
            await _context.SaveChangesAsync();
        }
    }
}
