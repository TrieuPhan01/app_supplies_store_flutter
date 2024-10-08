namespace Backend_ASP.NET.Models
{
    public class CategoriesModel
    {
        public Guid CategoryID { get; set; }
        public string? Name { get; set; }
        public string? Unit { get; set; }
        public string? Note { get; set; }
        public List<ProductsModel>? Products { get; set; }
    }
    public class CategoriesMPost
    {
        public Guid CategoryID { get; set; }
        public string? Name { get; set; }
        public string? Unit { get; set; }
        public string? Note { get; set; }
    }
}
