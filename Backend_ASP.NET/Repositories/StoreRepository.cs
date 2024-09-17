using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Repositories
{
    public class StoreRepository: IStoreRepository
    {
        private readonly MyAppDBConText _context;
        private readonly IMapper _mapper;

        public StoreRepository(MyAppDBConText conText, IMapper mapper) 
        { 
            _context = conText;
            _mapper = mapper;
        }

        public async Task Add(StoreModel store)
        {
            if (store == null)
            {
                throw new ArgumentNullException(nameof(store), "Customer cannot be null.");
            }
            var stores = _mapper.Map<Stores>(store);
            await _context.Stores.AddAsync(stores);
            await _context.SaveChangesAsync();
        }


        public async Task<List<StoreModel>> GetAll()
        {
            var _stores = await _context.Stores.ToListAsync();
            if (_stores == null)
            {
                return null!;
            }
            var storeModels = _mapper.Map<List<StoreModel>>(_stores);
           
            return storeModels;
        }

        public async Task<StoreModel> GetByID(Guid id)
        {
            var _store = await _context.Stores.FindAsync(id);
            if (_store == null)
            {
                return null!;
            }
            var storeModel = _mapper.Map<StoreModel>(_store);
            return storeModel;
        }

    }
}
