public class SetLeadClientType {

    public static void setLeadCientType(Integer n, Integer k) {
        
        List<Lead> leads  = [Select Id, Phone From Lead];
        
        for(Lead lead: leads)
        {
            Integer last = Integer.valueOf(lead.Phone.right(1));
			if (last>=n && last<=k)
                lead.Client_Type__c = 'Customer';
            else  lead.Client_Type__c = 'Dealer';
        			
        }
        update leads;
        
    }
    
}