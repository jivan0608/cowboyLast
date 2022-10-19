@isTest
public class TestOpportunityTriger {
    
    @isTest static void testInsertionOpportunityTrigger() {
        //creating a test account
        Account testAccount = new Account(Name = 'Test Account for Opportunity Trigger1');
        insert testAccount;      
        
       Opportunity opportunityForTest1 = new Opportunity(Name = testAccount.Name + ' OpportunityForTest1a ',
                                                                     StageName = 'Closed Won',
                                                                     CloseDate = System.today().addMonths(2),
                                                                     AccountId = testAccount.Id,
                                                                     Amount = 100000);
        
        Opportunity opportunityForTest2 = new Opportunity(Name = testAccount.Name + ' OpportunityForTest1a ',
                                                                     StageName = 'Prospecting',
                                                                     CloseDate = System.today().addMonths(2),
                                                                     AccountId = testAccount.Id,
                                                                     Amount = 50000);
        Test.startTest();
        insert opportunityForTest1;
        insert opportunityForTest2;
        Test.stopTest();
        	testAccount = [
                Select Rating_Rate__c
                From Account
                Where Id = :testAccount.Id
            ];
        
        	System.debug('Rating for the testAccount: ' + testAccount.Rating_Rate__c );
         	System.assert(testAccount.Rating_Rate__c==100000);
    }
     @isTest static void testUpdateOpportunityTrigger() {
           //creating a test account
        Account testAccount = new Account(Name = 'Test Account for Opportunity Trigger2');
        insert testAccount;      
        
        //creating and uppdating opportuinity
        Opportunity opportunityForTest1 = new Opportunity(Name = testAccount.Name + ' OpportunityForTest2a ',
                                                                     StageName = 'Closed Won',
                                                                     CloseDate = System.today().addMonths(2),
                                                                     AccountId = testAccount.Id,
                                                                     Amount = 100000);
        
        
         insert opportunityForTest1;
         opportunityForTest1.Amount=150000;
         
         Test.startTest();
         update opportunityForTest1;
         Test.stopTest();
              
         testAccount = [
                Select Rating_Rate__c
                From Account
                Where Id = :testAccount.Id
            ];
         System.debug('Rating for the testAccount: ' + testAccount.Rating_Rate__c );
         System.assert(testAccount.Rating_Rate__c==150000);
    }
    
    @isTest static void testDeleteOpportunityTrigger() {
           //creating a test account
        Account testAccount = new Account(Name = 'Test Account for Opportunity Trigger2');
        insert testAccount;      
        
        //creating and deleting opportuinity
        Opportunity opportunityForTest = new Opportunity(Name = testAccount.Name + ' OpportunityForTest3a ',
                                                                     StageName = 'Closed Won',
                                                                     CloseDate = System.today().addMonths(2),
                                                                     AccountId = testAccount.Id,
                                                                     Amount = 100000);
        
        
         insert opportunityForTest;
         
         Test.startTest();
         delete opportunityForTest;
         Test.stopTest();
              
         testAccount = [
                Select Rating_Rate__c
                From Account
                Where Id = :testAccount.Id
            ];
         System.debug('Rating for the testAccount: ' + testAccount.Rating_Rate__c );
         System.assert(testAccount.Rating_Rate__c==0);
    }
    
    @isTest static void testUnDeleteOpportunityTrigger() {
           //creating a test account
        Account testAccount = new Account(Name = 'Test Account for Opportunity Trigger2');
        insert testAccount;      
        
        //creating and deleting opportuinity
        Opportunity opportunityForTest = new Opportunity(Name = testAccount.Name + ' OpportunityForTest3a ',
                                                                     StageName = 'Closed Won',
                                                                     CloseDate = System.today().addMonths(2),
                                                                     AccountId = testAccount.Id,
                                                                     Amount = 100000);
        
        
         insert opportunityForTest;
         
        delete opportunityForTest;
         Test.startTest();
         undelete opportunityForTest;
         Test.stopTest();
              
         testAccount = [
                Select Rating_Rate__c
                From Account
                Where Id = :testAccount.Id
            ];
         System.debug('Rating for the testAccount: ' + testAccount.Rating_Rate__c );
         System.assert(testAccount.Rating_Rate__c==100000);
    }

}