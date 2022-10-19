trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
 //List<Opportunity> opps = [SELECT Id,Name, StageName FROM Opportunity
  //      WHERE Id IN :Trigger.New];
    
    List<Task> toUpdate = new List<Task>();
    
    for(Opportunity opp : Trigger.New) {
        
        if(opp.StageName=='Closed Won' ) {
           toUpdate.add(new Task(Subject = 'Follow Up Test Task', WhatId  = opp.Id));
        }
    }
    
  	update toUpdate;
}