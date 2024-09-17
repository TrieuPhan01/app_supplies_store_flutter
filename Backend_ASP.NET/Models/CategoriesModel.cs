﻿namespace Backend_ASP.NET.Models
{
    public class CategoriesModel
    {
        public Guid CategoryID { get; set; }
        public string? Name { get; set; }
        public string? Unit { get; set; }
        public string? Note { get; set; }
        public CategoriesModel()
        {
            // Tự động tạo Guid ngẫu nhiên
            CategoryID = Guid.NewGuid();
        }
    }
}
