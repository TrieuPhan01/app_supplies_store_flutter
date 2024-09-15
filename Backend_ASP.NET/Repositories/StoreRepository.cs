using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Repositories
{
    public class StoreRepository: IStoreRepository
    {
        private readonly MyAppDBConText _context;

        public StoreRepository(MyAppDBConText conText) 
        { 
            _context = conText;
        }

        public async Task Add(StoreModel store)
        {
            if (store == null)
            {
                throw new ArgumentNullException(nameof(store), "Customer cannot be null.");
            }

            var stores = new Stores
            {
               StoreName = store.StoreName,
               Address = store.Address,
               ImageStore = store.ImageStore,
            };

            await _context.Stores.AddAsync(stores);
            await _context.SaveChangesAsync();
        }


        public async Task<List<StoreModel>> GetAll()
        {
            var _stores = await _context.Stores.ToListAsync();
            var storeModels = new List<StoreModel>();

            if (_stores != null)
            {
                foreach (var st in _stores)
                {
                    storeModels.Add(new StoreModel
                    {
                        StoreID = st.StoreID,
                        StoreName = st.StoreName,
                        Address = st.Address,
                        ImageStore = st.ImageStore,
                    });
                }
            }
            return storeModels;
        }

        public async Task<StoreModel> GetByID(Guid id)
        {
            var _store = await _context.Stores.FindAsync(id);
            if (_store == null)
            {
                throw new Exception("Customer not found.");
            }

            return new StoreModel
            {
                StoreID = _store.StoreID,
                StoreName = _store.StoreName,
                Address = _store.Address,
                ImageStore = _store.ImageStore,
            };
        }

    }
}
