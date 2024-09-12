using Backend_ASP.NET.Models;
using Backend_ASP.NET.Repositories;
using Backend_ASP.NET.Services;
using Microsoft.AspNetCore.Mvc;

[Route("Admin")]
public class AdminController : Controller
{
    private readonly IUserRepository _userRepository;

    public IAccountRepository accountRepo;

    public AdminController(IUserRepository userRepository, IAccountRepository repo)
    {
        _userRepository = userRepository;
        accountRepo = repo;
    }

    [HttpGet("Index")]
    public IActionResult Index()
    {
        return View();
    }


    // View User in Admin 
    [HttpGet("User")]
    public async Task<IActionResult> Users()
    {
        var users = await _userRepository.GetAll(); 
        return View("~/Views/User/Index.cshtml", users);
    }

    [HttpGet("User/Edit/{id}")]
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
        public IActionResult Create()
        {
            var model = new SignUpModel(); // Khởi tạo model. Nếu không khởi tạo thì  Layout = "~/Views/Shared/_AdminLayout.cshtml"; lỗi null!
        return View("~/Views/User/Create.cshtml", model); 
        }

    [HttpPost("User/Create")]//Action thêm thông tin người dùng
        public async Task<IActionResult> Create(SignUpModel user)
        {
            if (ModelState.IsValid)
            {
                await accountRepo.SingUpAsync(user);
                return Redirect("/Admin/User");
            }
            return View("~/Views/User/Create.cshtml", user); 
        }

}





