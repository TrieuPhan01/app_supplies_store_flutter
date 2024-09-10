using Microsoft.AspNetCore.Identity;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using System.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend_ASP.NET.Services
{
    public class UserRepository : IUserRepository
    {
        private readonly MyAppDBConText _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
       
        public UserRepository(MyAppDBConText context, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            //_passwordHasher = passwordHasher;
            _context = context;
        }

        public UserEditViewModel GetByID(string id)
        {
            var user = _context.AppilcationUser.FirstOrDefault(x => x.Id == id);
            var role = GetUserRole(user.Id);
            if (user != null)

            {
                return new UserEditViewModel
                {
                    Id = user.Id,
                    UserName = user.UserName,
                    Email = user.Email,
                    PhoneNumber = user.PhoneNumber,
                    Roles = role,

                };
            }
            return null!;
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

        public async Task<List<UserEditViewModel>> GetAll()
        {
            var users = await _context.AppilcationUser.ToListAsync();
            var userModels = new List<UserEditViewModel>();


            foreach (var user in users)
            {

                userModels.Add(new UserEditViewModel
                {
                    Id = user.Id,
                    UserName = user.UserName,
                    Email = user.Email,
                    PhoneNumber = user.PhoneNumber,
                    Roles = GetUserRole(user.Id)


                });
            }

            return userModels;
        }

        public void Update(UserEditViewModel user)
        {
            var _user = _context.ApplicationUsers.SingleOrDefault(x => x.Id == user.Id);
            if (_user != null)
            {
                _user.UserName = user.UserName;
                _user.Email = user.Email;
                if (!string.IsNullOrEmpty(user.PassWord))
                {
                    _user.PasswordHash = user.PassWord;
                }
                _user.PhoneNumber = user.PhoneNumber;

                // Cập nhật role của user
                var currentRoles = _context.ApplicationUserRoles.Where(ur => ur.UserId == _user.Id).ToList();
                if (currentRoles != null)
                {
                    // Xóa các vai trò cũ
                    _context.ApplicationUserRoles.RemoveRange(currentRoles);
                }

                // Thêm vai trò mới
                var newRole = _context.Roles.SingleOrDefault(r => r.Name == user.Roles);
                if (newRole != null)
                {
                    _context.ApplicationUserRoles.Add(new ApplicationUserRole
                    {
                        UserId = _user.Id,
                        RoleId = newRole.Id
                    });
                }

                _context.SaveChanges();
            }
        }



        public string? GetUserRole(string id)
        {
            var currentuser = _context.Users.FirstOrDefault(x => x.Id == id);  // Truy vấn bảng Users (AspNetUsers)
            if (currentuser == null)
            {
                return null; // Nếu không tìm thấy user, trả về null
            }

            // Truy vấn bảng AspNetUserRoles để lấy thông tin RoleId của user
            var userRole = _context.UserRoles  // Đây là bảng AspNetUserRoles
                .FirstOrDefault(x => x.UserId == currentuser.Id);

            if (userRole == null)
            {
                return null; // Nếu không tìm thấy role, trả về null
            }

            // Truy vấn bảng AspNetRoles để lấy tên role dựa trên RoleId
            var role = _context.Roles  // Đây là bảng AspNetRoles
                .FirstOrDefault(r => r.Id == userRole.RoleId);

            if (role == null)
            {
                return null; // Nếu không tìm thấy role, trả về null
            }

            // Trả về tên của Role
            return role.Name;
        }

      
    }
}
