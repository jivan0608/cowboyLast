@isTest
private class TestRestrictContactByName {
    
    @isTest static void TestInsertion() {
        
        Contact contact = new Contact(LastName = 'INVALIDNAME');
        Test.startTest();
        Database.SaveResult result = Database.insert(contact);
        Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size()>0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',result.getErrors()[0].getMessage());
              
        
    }
     @isTest static void TestUpdate() {
        
        Contact contact = new Contact(LastName = 'ProperName');
        Test.startTest();
        Database.SaveResult resultSuccess = Database.insert(contact);
        
        System.assert(resultSuccess.isSuccess());
        System.assert(resultSuccess.getErrors().size()==0);
         
        contact.LastName = 'INVALIDNAME';
         
        Database.SaveResult result = Database.update(contact);
         Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size()>0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',result.getErrors()[0].getMessage());
              
        
    }
    

}