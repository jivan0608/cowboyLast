public class RandomContactFactory {

   	public static List<Contact> generateRandomContacts(Integer n, String last)
    {
        
        List<Contact> resultList = new List<Contact>();
        for (Integer i = 1; i<=n; i++)
        {
            
            resultList.add(new Contact(FirstName = 'Test ' + i, LastName = last));
            
        }
        return resultList;
        
    }
    
}