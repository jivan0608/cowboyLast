public without sharing class OpportunityTriggerHelper {
    public OpportunityTriggerHelper() {
        System.debug('Inside OpportunityTriggerHelper Constructor');
    }
    public void updateAmount(List <Opportunity> opportunities) {
   				Set<Id> accountIds = getAccountIds(opportunities);
        		System.debug('Set<Id> accountIds ' + accountIds );
        		Map<Id,Decimal> accountIdToAmountMap = getAccountIdToAmountMap(accountIds);
        		System.debug('accountIdToAmountMap ' + accountIdToAmountMap );
        		List<Account> accountsToUpdate = getAccountsToUpdate(accountIdToAmountMap);
         		System.debug('accountsToUpdate: ' + accountsToUpdate);
        		update accountsToUpdate;
                    
    }
        
	private Set<Id> getAccountIds(List <Opportunity> opportunities) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opportunity : opportunities) {
            if(opportunity.StageName=='Closed Won' && opportunity.AccountId!=NULL){
            accountIds.add(opportunity.AccountId);}
    	}
            return accountIds;
	}
    
    private Map<Id,Decimal> getAccountIdToAmountMap(Set<Id> accountIds) {
        Map<Id,Decimal> accountIdToAmountMap = new Map<Id,Decimal>();
        for(Id accountId: accountIds) {
            
            Decimal totalAmount = 0;
            List<Opportunity> actualOpportunities = [
                Select Id,Amount 
                FROM Opportunity 
                WHERE AccountId = :accountId 
                AND StageName = 'Closed Won'
            ];
        	        
        for(Opportunity actualOpportunity : actualOpportunities) {
            if(actualOpportunity.Amount!=null){
                totalAmount+=actualOpportunity.Amount;}
        }
        	accountIdToAmountMap.put(accountId,totalAmount);
            
            
    	}
            return accountIdToAmountMap;
	}
    
    private List<Account> getAccountsToUpdate(Map<Id,Decimal> accountIdToAmountMap){
        List<Account> accountsToUpdate = [
            Select Id, Rating_Rate__c 
            FROM Account 
            WHERE Id = :accountIdToAmountMap.keySet()
        ];
        
        for (Account accountToUpdate : accountsToUpdate) {
        accountToUpdate.Rating_Rate__c = accountIdToAmountMap.get(accountToUpdate.Id);
    }
        return accountsToUpdate;
    }
    
}