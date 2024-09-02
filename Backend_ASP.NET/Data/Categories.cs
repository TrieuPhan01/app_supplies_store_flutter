namespace Backend_ASP.NET.Data
{
    public class Categories
    {
        public Guid CategoryID { get; set; }
        public string? Name { get; set; }
        public string? Unit { get; set; }
        public string? Note { get; set; }

        public ICollection<Products> Products { get; set; }
        public Categories()
        {
            Products = new List<Products>();
           
        }
    }
}
