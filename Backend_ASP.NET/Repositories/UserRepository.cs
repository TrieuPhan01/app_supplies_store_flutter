﻿using Microsoft.AspNetCore.Identity;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using System.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Backend_ASP.NET.Helpers;

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
            _context = context;
        }

        public async Task<UserEditViewModel> GetByID(string id)
        {
            var user = await _context.AppilcationUser.FirstOrDefaultAsync(x => x.Id == id);
            var role = await GetUserRole(user.Id); // Lấy role bất đồng bộ
            if (user != null)
            {
                return new UserEditViewModel
                {
                    Id = user.Id,
                    UserName = user.UserName,
                    Email = user.Email,
                    FirstName = user.FirstName,
                    LastName = user.LastName,
                    PhoneNumber = user.PhoneNumber,
                    Roles = role,
                };
            }
            return null!;
        }


        public async Task Delete(string id)
        {
            var _user = await _context.ApplicationUsers.SingleOrDefaultAsync(x => x.Id == id);
            if (_user != null)
            {
                _context.Users.Remove(_user);
                await _context.SaveChangesAsync();
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
                    FirstName = user.FirstName,
                    LastName = user.LastName,
                    PhoneNumber = user.PhoneNumber,
                    Roles = await GetUserRole(user.Id)


                });
            }

            return userModels;
        }

        public async Task Update(UserEditViewModel user)
        {
            var _user = _context.ApplicationUsers.SingleOrDefault(x => x.Id == user.Id);

            if (_user != null)
            {
                _user.UserName = user.UserName;
                _user.Email = user.Email;
                _user.FirstName = user.FirstName;
                _user.LastName = user.LastName;
                _user.PhoneNumber = user.PhoneNumber;

                // Cập nhật mật khẩu nếu có
                if (!string.IsNullOrEmpty(user.PassWord))
                {
                    var passwordHasher = new PasswordHasher<ApplicationUser>();
                    _user.PasswordHash = passwordHasher.HashPassword(_user, user.PassWord);
                }

                // Kiểm tra vai trò của user
                if (!await _roleManager.RoleExistsAsync(user.Roles))
                {
                    // Nếu vai trò chưa tồn tại, tạo vai trò mới
                    await _roleManager.CreateAsync(new IdentityRole(user.Roles));
                }

                // Xóa tất cả các vai trò hiện có của người dùng
                var currentRoles = await _userManager.GetRolesAsync(_user);
                if (currentRoles.Count > 0)
                {
                    await _userManager.RemoveFromRolesAsync(_user, currentRoles);
                }

                // Thêm vai trò mới cho người dùng
                await _userManager.AddToRoleAsync(_user, user.Roles);

                // Lưu các thay đổi vào cơ sở dữ liệu
                await _context.SaveChangesAsync();
            }
        }






        public async Task<string?> GetUserRole(string id)
        {
            var currentuser = await _context.Users.FirstOrDefaultAsync(x => x.Id == id);
            if (currentuser == null)
            {
                return null;
            }

            var userRole = await _context.UserRoles.FirstOrDefaultAsync(x => x.UserId == currentuser.Id);
            if (userRole == null)
            {
                return null;
            }

            var role = await _context.Roles.FirstOrDefaultAsync(r => r.Id == userRole.RoleId);
            if (role == null)
            {
                return null;
            }

            return role.Name;
        }





    }
}
