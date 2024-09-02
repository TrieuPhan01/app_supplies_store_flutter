using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.Blazor;

namespace Backend_ASP.NET.Data
{
    public abstract class BaseModel
    {
        public Guid? ID { get; set; } = Guid.NewGuid();
        public DateTime CreatedDate { get; set; } 
        public DateTime UpdateDate { get; set; }
    }
}
