using AutoMapper;
using Backend_ASP.NET.Data;
using Backend_ASP.NET.Models;

namespace Backend_ASP.NET.Helpers
{
    public class ApplicationMapper : Profile
    {
        public ApplicationMapper() 
        {
            CreateMap<Employee, EmployeesModel>().ReverseMap();
            CreateMap<Custommers, CustomerModel>().ReverseMap();
            CreateMap<Categories, CategoriesModel>().ReverseMap();
            CreateMap<Debits, DebitsModel>().ReverseMap();
            CreateMap<ApplicationUser, UserEditViewModel>().ReverseMap();
            CreateMap<Stores, StoreModel>().ReverseMap();
            CreateMap<Suppliers, SuppliersModel>().ReverseMap();
            CreateMap<Products, ProductsModel>().ReverseMap();
        }
    }
}
