public class NewCaseListController {

    public List<Case> getNewCases()
    {
			List<Case> allResult = Database.query('Select ID, CaseNumber,Status ' + 
                                              'FROM CASE ' ) ;
        	List<Case> result = new List<Case>();
        for(Case cs : allResult) {
            
            if (cs.Status == 'New'){
					result.add(cs);
            }       
            
        }
                return result;
    }
    
}