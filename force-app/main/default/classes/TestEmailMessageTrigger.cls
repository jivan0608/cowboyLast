@isTest
public class TestEmailMessageTrigger {
     @testSetup static void setup() {
          Case firstCase = new Case(
          CurrencyIsoCode = 'USD'
         ,Origin = 'Email'
         ,Status = 'New'
         ,SuppliedEmail = 'test@dog.com'
          );   
          insert firstCase;       
         Case secondCase = new Case(
          CurrencyIsoCode = 'EUR'
         ,Origin = 'Email'
         ,Status = 'New'
         ,SuppliedEmail = 'test@dog.com'
          );   
          insert secondCase;
         }
    public static testMethod void testEmailTrigger(){
       Case secondCase = ([
           Select id
           FROM Case
           Where CurrencyIsoCode = 'EUR'
       ]).get(0);
       EmailMessage connectedMessage = new EmailMessage(
             Subject                = 'the most important'
    		,FromAddress            = 'test@dog.com'
            ,TextBody				= 'Test text'
    		,Incoming               = true
    		,MessageDate            = DateTime.now().addHours(1)
            ,ParentId				= secondCase.Id
    													);
        Test.startTest();
        insert connectedMessage;
        Test.stopTest();
        List<Case> activeCases = [
            SELECT iD
            FROM Case
            WHERE Status!='Closed' AND SuppliedEmail = 'test@dog.com'
        ];
        Case activeCase = activeCases.get(0);
        EmailMessage message = ([
            SELECT Id,ParentId
            FROM EmailMessage
            WHERE  Subject  = 'the most important'
        ]).get(0);
        System.assertEquals(1,activeCases.size()); 
        System.assertEquals(activeCase.Id,message.ParentId);   
        
    }
}