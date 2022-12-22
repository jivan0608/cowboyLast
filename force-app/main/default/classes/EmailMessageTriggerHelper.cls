public with sharing class EmailMessageTriggerHelper {
    public EmailMessageTriggerHelper() {
    }
    public void processIncomingMessages(List<EmailMessage> incomingMessages){
        List<String> fromAdresses = new List<String>();
        for(EmailMessage emailMessage: incomingMessages){
            fromAdresses.add(emailMessage.FromAddress);
        }	
        //get the list of existing parent cases
        List<Case> parents = [
            SELECT id, SuppliedEmail
            FROM Case
            WHERE SuppliedEmail=:fromAdresses AND Status!='Closed'
            ORDER BY CreatedDate ASC
        ];
        //create a map with FromAdress - Parent cases pairs
        Map<String,List<Case>> emailToCasesMap = new Map<String,List<Case>>();
        
        for(Case cs: parents){
            List<Case> cases;
            if(emailToCasesMap.containsKey(cs.SuppliedEmail)){
                cases = emailToCasesMap.get(cs.SuppliedEmail);
                cases.add(cs);
            }
            else{
                cases = new List<Case>();
                cases.add(cs);
           }
           emailToCasesMap.put(cs.SuppliedEmail,cases);
        }
        //check amount of cases for each email and process duplicates
        List<Case> duplicates = new List<Case>();
        for(EmailMessage emailMessage: incomingMessages){
            List<Case> currentParents = emailToCasesMap.get(emailMessage.FromAddress);
            if(currentParents.size()<2) {continue;}
            //assign the oldest case as a parent
            emailMessage.ParentId = currentParents[0].Id;
            //deleting duplicate
       	    duplicates.add(currentParents[currentParents.size()-1]);
        }	
        delete duplicates;
    }
}