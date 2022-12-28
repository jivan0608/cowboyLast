public with sharing class LeadService {
 
    @AuraEnabled
    public static void saveLeads(List<Lead> leads){
       insert leads;
    }
    @AuraEnabled
    public static List<String> getDuplicates(List<Lead> leads){
        List<String> emails = new List<String>();
        Set<String> duplicates = new Set<String>();
        for(Lead lead: leads){
            if(lead.Email!=null){
                emails.add(lead.Email);
            }
        }
        List<Lead> leadDuplicates=[
            SELECT id,Email
            FROM Lead
            WHERE Email = :emails
        ];
        List<Account> accDuplicates=[
            SELECT id,PersonEmail
            FROM Account
            WHERE PersonEmail = :emails
        ];
        for(Lead ld: leadDuplicates){
            duplicates.add(ld.Email);
        }
        for(Account acc: accDuplicates){
            duplicates.add(acc.PersonEmail);
        }
        System.debug('Duplicates'+ duplicates.size());
        return new List<String>(duplicates);
    }
}