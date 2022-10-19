public without sharing class OpportunityTriggerHandler implements TriggerHandler {
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public OpportunityTriggerHelper helper;
    public OpportunityTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new OpportunityTriggerHelper();
    }
    
    public void beforeInsert(List<Opportunity> newOpportunities) {
        // reserved;
      
    }
    public void beforeUpdate(List<Opportunity> oldOpportunities, List<Opportunity> newOpportunities, Map<ID, SObject> oldOpportunityMap, Map<ID, SObject> newOpportunityMap) {
        // reserved;
    }
    public void beforeDelete(List<Opportunity> oldOpportunities, Map<ID, SObject> oldOpportunityMap) {
        // reserved;
    }
    public void afterInsert(List<Opportunity> newOpportunities, Map<ID, SObject> newOpportunityMap) {
        helper.updateAmount(newOpportunities);        
    }
    public void afterUpdate(List<Opportunity> oldOpportunities, List<Opportunity> newOpportunities, Map<ID, SObject> oldOpportunityMap, Map<ID, SObject> newOpportunityMap) {
        helper.updateAmount(newOpportunities);     
    }
    public void afterDelete(List<Opportunity> oldOpportunities, Map<ID, SObject> oldOpportunityMap) {
        helper.updateAmount(oldOpportunities);     
    }
    public void afterUndelete(List<Opportunity> newOpportunities, Map<ID, SObject> newOpportunityMap) {
        helper.updateAmount(newOpportunities);     
    }
}