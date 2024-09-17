using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Microsoft.EntityFrameworkCore;
using System.Xml.Linq;

namespace Backend_ASP.NET.Repositories
{
    public class DebtitsRepository : IDebitsRepository
    {
        private readonly MyAppDBConText _context;
        private readonly IMapper _mapper;

        public DebtitsRepository(MyAppDBConText conText, IMapper mapper)
        {
            _context = conText;
            _mapper = mapper;

        }
        public async Task Add(DebitsModel debit)
        {
            if (debit == null)
            {
                throw new ArgumentNullException(nameof(debit), "Debit cannot be null.");
            }

            var curentDebit = _mapper.Map<Debits>(debit);

            await _context.Debits.AddAsync(curentDebit);
            await _context.SaveChangesAsync();
        }

        public async Task Delete(Guid id)
        {
            var _debit = await _context.Debits.FindAsync(id);
            if (_debit == null)
            {
                throw new Exception("Debit not found.");
            }

            _context.Debits.Remove(_debit);
            await _context.SaveChangesAsync();
        }

        public async Task<List<DebitsModel>> GetAll()
        {
            var allDebits = await _context.Debits.ToListAsync();
            if (allDebits == null)
            {
                throw new Exception("Debit not found.");
            }
            var debitsModels = _mapper.Map<List<DebitsModel>>(allDebits);
            return debitsModels;
        }

        public async Task<DebitsModel> GetByID(Guid id)
        {
          var _debit = await _context.Debits.FindAsync(id);
            if (_debit == null)
            {
                throw new Exception("Debit not found.");
            }
            var debit = _mapper.Map<DebitsModel>(_debit);
            return debit;
        }

        public async Task Update(DebitsModel debits)
        {
            var _currentDebit = await _context.Debits.FindAsync(debits.ID);
            if (_currentDebit == null)
            {
                throw new Exception("Debit not found.");
            }
            _mapper.Map(debits,_currentDebit);
            await _context.SaveChangesAsync();
        }
    }
}
