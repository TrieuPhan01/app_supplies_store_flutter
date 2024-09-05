using Microsoft.AspNetCore.Identity;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Services
{
    public class UserRepository : IUserRepository
    {
        private readonly MyAppDBConText _context;
        //private readonly IPasswordHasher<AppilcationUser> _passwordHasher;

        //public UserRepository(MyAppDBConText context, IPasswordHasher<AppilcationUser> passwordHasher)
        public UserRepository(MyAppDBConText context)
        {
            _context = context;
            //_passwordHasher = passwordHasher;
        }

        public UserModel Add(UserModel user)
        {
            var _user = new AppilcationUser
            {
                //Id = user.Id,
                UserName = user.UserName,
                Email = user.Email,
                PhoneNumber = user.PhoneNumber,
                UserRole = user.UserRole,
            };

            // Băm mật khẩu và lưu vào đối tượng Users
            _user.PasswordHash = user.PassWord;
            _context.Users.Add(_user);
            _context.SaveChanges();

            return new UserModel
            {
                //Id = user.Id,
                UserName = _user.UserName,
                Email = _user.Email,
                PhoneNumber = _user.PhoneNumber,
                UserRole = _user.UserRole,
                PassWord = _user.PasswordHash
            };
        }

        public void Delete(string id)
        {
            var _user = _context.AppilcationUser.SingleOrDefault(x => x.Id == id);
            if (_user != null)
            {
                _context.Users.Remove(_user);
                _context.SaveChanges();
            }
        }

        public List<UserModel> GetAll()
        {
            var users = _context.AppilcationUser.Select(x => new UserModel
            {
                UserName = x.UserName,         
                Email = x.Email,
                PhoneNumber = x.PhoneNumber,
                UserRole = x.UserRole

            });
            return users.ToList();
        }

        public UserModel GetByID(string id)
        {
            var user = _context.AppilcationUser.FirstOrDefault(x => x.Id == id);
            if (user != null)
            {
                return new UserModel
                {
                    UserName = user.UserName,
                    Email = user.Email,
                    PhoneNumber = user.PhoneNumber,
                    UserRole = user.UserRole
                };
            }
            return null!;
        }

        public void Update(UserUpdate user)
        {
            var _user = _context.Users.SingleOrDefault(x => x.Id == user.Id);
            if (_user != null)
            {
                _user.UserName = user.UserName;
                _user.Email = user.Email;
                if (!string.IsNullOrEmpty(user.PassWord)) // Băm mật khẩu nếu có thay đổi
                {
                    _user.PasswordHash =  user.PassWord;
                }
                _user.PhoneNumber = user.PhoneNumber;
                _user.UserRole = user.UserRole;

                _context.SaveChanges();
            }
        }
    }
}
