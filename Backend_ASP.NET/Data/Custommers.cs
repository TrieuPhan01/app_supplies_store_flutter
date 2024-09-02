namespace Backend_ASP.NET.Data
{
    public enum sexEnum
    {
        Male, Female

    }
    public class Custommers: Users
    {   
        public String? FirstName { get; set; }
        public String? LastName { get; set; }
        public int? Age { get; set; }
        public sexEnum? Sex { get; set; }
        public String? Address { get; set; }
        public String? Avatar { get; set; }
        //Relationship
        public Debits? Debits { get; set; }

        public Users? Users { get; set; }

        public ICollection<StoreCustomer> StoreCustomers { get; set; } 
        public ICollection<Orders> Orders { get; set; }

        public Custommers()
        {
            StoreCustomers = new List<StoreCustomer>();
            
        }

    }
}
