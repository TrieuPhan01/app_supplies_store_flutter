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
    private readonly IEmployeeRepository _employeeRepository;
    private readonly ICustomerRepository _customerRepository;
    private readonly ISuppliersRepository _suppliersRepository;
    private readonly ICategoriesRepository _categoriesRepository;
    private readonly IProductsRepository _productsRepository;
    private readonly IDebitsRepository _debitsRepository;

    public AdminController(IDebitsRepository debitsRepository, IProductsRepository productsRepository, ICategoriesRepository categoriesRepository, ISuppliersRepository suppliersRepository, ICustomerRepository customerRepository, IEmployeeRepository employeeRepository, UserManager<ApplicationUser> userManager,IUserRepository userRepository, IAccountRepository repo, IAccountRepository accountRepository, SignInManager<ApplicationUser> signInManager)
    {
        this._userRepository = userRepository;
        this.accountRepo = repo;
        this._accountRepository = accountRepository;
        this._userManager = userManager;
        this._signInManager = signInManager;
        this._employeeRepository = employeeRepository;
        this._customerRepository = customerRepository;
        this._suppliersRepository = suppliersRepository;
        this._categoriesRepository = categoriesRepository;
        this._productsRepository = productsRepository;
        this._debitsRepository = debitsRepository;


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


    [HttpGet("Employees")]
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Emlpoyees()
    {
        var _employees = await _employeeRepository.GetAll();
        return View("~/Views/Employees/Index.cshtml", _employees);
    }

    [HttpGet("Customers")]
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Customers()
    {
        var _customers = await _customerRepository.GetAll();
        return View("~/Views/Customers/Index.cshtml", _customers);
    }



    [HttpGet("Suppliers")]
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Suppliers()
    {
        var _suppliers = await _suppliersRepository.GetAll();
        return View("~/Views/Suppliers/Index.cshtml", _suppliers);
    }

    
    /// <summary>
    /// quản lý danh mục sản phẩm
    /// </summary>
    /// <returns></returns>
    [HttpGet("Categories")]
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Categories()
    {
        var _categories = await _categoriesRepository.GetAll();
        return View("~/Views/Categories/Index.cshtml", _categories);
    }

    [HttpGet("Categories/Product/{id}")]
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> ViewProduct(string id)
    {
        var _products = await _productsRepository.GetByCategoryID(Guid.Parse(id));
        if (_products == null)
        {
            return NotFound();
        }

        return View("~/Views/Products/Index.cshtml", _products);
    }


    [HttpGet("Debits")]
    [Authorize(Roles = "Adminstrator, Staff")]
    public async Task<IActionResult> Debits()
    {
        var _debits = await _debitsRepository.GetAll();
        return View("~/Views/Debits/Index.cshtml", _debits);
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





