using Backend_ASP.NET.Models;
using Backend_ASP.NET.Services;
using Microsoft.AspNetCore.Mvc;

[Route("Admin")]
public class AdminController : Controller
{
    private readonly IUserRepository _userRepository;

    public AdminController(IUserRepository userRepository)
    {
        _userRepository = userRepository;
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
    public IActionResult Edit(string id)
    {
        var user = _userRepository.GetByID(id);
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
            _user.PhoneNumber = user.PhoneNumber;
            
            //_user.UserRole = user.UserRole;
            if(_user.PassWord != null)
            {
                _user.PassWord = user.PassWord;
            }    

            _userRepository.Update(_user);

            return RedirectToAction("Users");
        }

        return View("~/Views/User/Edit.cshtml", user);

    }
}
