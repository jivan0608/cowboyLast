public without sharing class EmailMessageTriggerHandler implements TriggerHandler {
        private boolean triggerIsExecuting;
        private integer triggerSize;
        public EmailMessageTriggerHelper helper;
        public EmailMessageTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
            this.triggerIsExecuting = triggerIsExecuting;
            this.triggerSize = triggerSize;
            this.helper = new EmailMessageTriggerHelper();
        }
        public void beforeInsert(List<EmailMessage> newEmailMessages) {
            helper.processIncomingMessages(newEmailMessages);
        }
        public void beforeUpdate(List<EmailMessage> oldEmailMessages, List<Account> newEmailMessages, Map<ID, SObject> oldEmailMessageMap, Map<ID, SObject> newEmailMessageMap) {
        }
        public void beforeDelete(List<EmailMessage> oldEmailMessages, Map<ID, SObject> oldAccountMap) {
        }
        public void afterInsert(List<EmailMessage> newAccounts, Map<ID, SObject> newEmailMessageMap) {
        }
        public void afterUpdate(List<EmailMessage> oldAccounts, List<Account> newEmailMessages, Map<ID, SObject> oldEmailMessageMap, Map<ID, SObject> newEmailMessageMap) {
        }
        public void afterDelete(List<EmailMessage> oldEmailMessages, Map<ID, SObject> oldEmailMessageMap) {
        }
        public void afterUndelete(List<Account> newEmailMessages, Map<ID, SObject> newEmailMessageMap) {
        }
    }