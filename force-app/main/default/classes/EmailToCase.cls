Global class EmailToCase implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope env){
        String address = env.fromAddress;
        System.debug('Incoming email from ' + address);
        System.debug('email text ' + email.plainTextBody);
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        System.debug('Database call');
        List<Case> activeCases = [
            SELECT id, SuppliedEmail,CaseNumber
            FROM Case
            WHERE Status!='Closed' AND SuppliedEmail =:address
        ];
        System.debug('active cases amount' + activeCases.size());
        if(activeCases.size()==0) {
            System.debug('No active cases are found');
            result.success=true;
            return result;}
        else {
            System.debug('Active case is found Case# ' + activeCases.get(0).CaseNumber );
            EmailMessage connectedMessage = new EmailMessage(
             Subject                = email.subject
    		//,ToAddress            	= email.toAddresses[0]
    		,FromAddress            = email.fromAddress
    		,FromName               = email.fromName
    		,HtmlBody               = email.htmlBody
            ,TextBody				= email.plainTextBody
    		,Incoming               = true
    		,MessageDate            = DateTime.now()
    													);
            connectedMessage.RelatedToId=activeCases.get(0).Id;
            connectedMessage.ParentId=activeCases.get(0).Id;
            insert connectedMessage;
            System.debug('No active cases are found');
            result.message = 'Your email has been attached to the active case';
            result.success=false;
            return result;
        }
        
    }

}