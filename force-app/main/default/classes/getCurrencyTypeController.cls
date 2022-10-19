public with sharing class getCurrencyTypeController {

    @AuraEnabled(cacheable=true)
     public static List<CurrencyType> getCurrencyType() {
     return [SELECT Isocode, ConversionRate FROM CurrencyType];
     }
   
}