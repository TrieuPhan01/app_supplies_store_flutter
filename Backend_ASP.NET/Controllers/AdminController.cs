using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;
using Backend_ASP.NET.Repositories;
using Backend_ASP.NET.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

[Route("Admin")]
public class AdminController : Controller
{
    private readonly IUserRepository _userRepository;
    private readonly IAccountRepository accountRepo;
    private readonly IAccountRepository _accountRepository;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly SignInManager<ApplicationUser> _signInManager;

    public AdminController(UserManager<ApplicationUser> userManager,IUserRepository userRepository, IAccountRepository repo, IAccountRepository accountRepository, SignInManager<ApplicationUser> signInManager)
    {
        this._userRepository = userRepository;
        this.accountRepo = repo;
        this._accountRepository = accountRepository;
        this._userManager = userManager;
        this._signInManager = signInManager;


    }

    [Authorize(Roles = "Adminstrator, Staff")]
    [HttpGet("Index")]
    public IActionResult Index()
    {
        return View();
    }


    [HttpGet("User")]
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Users()
    {
        var users = await _userRepository.GetAll();
        return View("~/Views/User/Index.cshtml", users);
    }

    [HttpGet("User/Edit/{id}")]
    [Authorize(Roles = "Adminstrator, Staff")]
    //[Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Edit(string id)
    {
        var user = await _userRepository.GetByID(id); 
        if (user == null)
        {
            return NotFound();
        }

        return View("~/Views/User/Edit.cshtml", user);
    }


    [HttpPost("User/Edit/{id}")]
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Edit(string id, UserEditViewModel user)
    {
        if (ModelState.IsValid)
        {
            var _user = await _userRepository.GetByID(id);
            if (_user == null)
            {
                return NotFound();
            }

            _user.UserName = user.UserName;
            _user.Email = user.Email;
            _user.FirstName = user.FirstName;
            _user.LastName = user.LastName;
            _user.PhoneNumber = user.PhoneNumber;
            _user.Roles = user.Roles;

            if (!string.IsNullOrEmpty(user.PassWord))
            {
                _user.PassWord = user.PassWord;
            }

            await _userRepository.Update(_user); 
            return RedirectToAction("Users");
        }

        return View("~/Views/User/Edit.cshtml", user);
    }


    [HttpGet("User/Delete/{id}")]// Action xác nhận xóa
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Delete(string id)
    {
        var user = await _userRepository.GetByID(id);
        if (user == null)
        { 
            return NotFound();
        }

        return View("~/Views/User/Delete.cshtml", user);
    }

    [HttpPost("User/Delete/{id}")]//Action xóa người dùng 
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> DeleteConfirmed(string id)
    {
        var user = await _userRepository.GetByID(id);
        if (user == null)
        {
            return NotFound();
        }

        await _userRepository.Delete(user.Id);

        return Redirect("/Admin/User");
    }


    [HttpGet("User/Create")]//Action view thêm người dùng
    [Authorize(Roles = "Adminstrator, Staff")]
    public IActionResult Create()
    {
        var model = new SignUpModel(); // Khởi tạo model. Nếu không khởi tạo thì  Layout = "~/Views/Shared/_AdminLayout.cshtml"; lỗi null!
        return View("~/Views/User/Create.cshtml", model); 
    }

    [HttpPost("User/Create")]//Action thêm thông tin người dùng
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Create(SignUpModel user)
    {
        if (ModelState.IsValid)
        {
            await accountRepo.SingUpAsync(user);
            return Redirect("/Admin/User");
        }
        return View("~/Views/User/Create.cshtml", user); 
    }


    [HttpGet("User/Login")]
    [AllowAnonymous]
    public IActionResult Login()
    {
        var model = new SignInModel();
        return View("~/Views/User/Login.cshtml", model);
    }


    [AllowAnonymous]
    [HttpPost("User/Login")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Login(SignInModel model)
    {
        if (ModelState.IsValid)
        {
            var user = await _userManager.Users.FirstOrDefaultAsync(u => u.PhoneNumber == model.PhoneNumber);
            if (user == null)
            {
                ModelState.AddModelError(string.Empty, "Số điện thoại không hợp lệ.");
                return View("~/Views/User/Login.cshtml", model);
            }

            var result = await _signInManager.PasswordSignInAsync(user.UserName, model.Password, false, lockoutOnFailure: true);
            if (result.Succeeded)
            {
                var roles = await _userManager.GetRolesAsync(user);
                if (roles.Contains("Adminstrator") || roles.Contains("Staff"))
                {
                    var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, user.UserName),
                    new Claim(ClaimTypes.NameIdentifier, user.Id)
                };

                    foreach (var role in roles)
                    {
                        claims.Add(new Claim(ClaimTypes.Role, role));
                    }

                    var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                    var authProperties = new AuthenticationProperties
                    {
                        IsPersistent = false,
                    };

                    await HttpContext.SignInAsync(
                        CookieAuthenticationDefaults.AuthenticationScheme,
                        new ClaimsPrincipal(claimsIdentity),
                        authProperties);

                    return RedirectToAction(nameof(Index));
                }
                else
                {
                    await _signInManager.SignOutAsync();
                    ModelState.AddModelError(string.Empty, "Bạn không có quyền truy cập.");
                }
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Đăng nhập không hợp lệ.");
            }
        }

        return View("~/Views/User/Login.cshtml", model);
    }

    [HttpPost("Logout")]
    [Authorize(Policy = "AdminOrStaff")]
    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return RedirectToAction("Login", "Admin");
    }


    private IActionResult RedirectToLocal(string returnUrl)
    {
        if (Url.IsLocalUrl(returnUrl))
        {
            return Redirect(returnUrl);
        }
        else
        {
            return RedirectToAction("Index", "Admin");
        }
    }
}





