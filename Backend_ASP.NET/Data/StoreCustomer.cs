namespace Backend_ASP.NET.Data
{
    public class StoreCustomer
    {
        public Guid StoreID { get; set; }
        public Stores? Stores { get; set; }

        public Guid? CustommerID { get; set; }
        public Custommers? Custommers { get; set; }
        
    }
}
