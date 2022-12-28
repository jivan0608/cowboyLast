@isTest
public class EmailToCaseTest {
  
    @testSetup static void setup() {
          Case darkCase = new Case(
          CurrencyIsoCode = 'USD'
         ,Origin = 'Email'
         ,Status = 'New'
         ,SuppliedEmail = 'test@dog.com'
          );   
          insert darkCase;             
         }
    
     public static testMethod void testEmailToCase(){
         
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.plainTextBody = 'Test sample';
        email.subject = 'test for a case';
        envelope.fromAddress = 'test@dog.com';
        EmailToCase testETC = new EmailToCase();
        Messaging.InboundEmailResult result = testETC.handleInboundEmail(email,envelope);
        List<Case> activeCases = [
            SELECT id, SuppliedEmail,CaseNumber
            FROM Case
            WHERE Status!='Closed' AND SuppliedEmail = 'test@dog.com'
        ];
         System.assertEquals(1,activeCases.size());
         List<EmailMessage> emails = [
          Select Id, TextBody,Subject
          FROM EmailMessage
          WHERE ParentId =:activeCases.get(0).Id
        ];
         System.assertEquals(1,emails.size());
         System.assertEquals('Test sample',emails.get(0).TextBody);
         System.assertEquals('test for a case',emails.get(0).subject);
         System.assertEquals(false,result.success);
    }
    	
}