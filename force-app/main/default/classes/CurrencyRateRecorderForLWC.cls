public with sharing class CurrencyRateRecorderForLWC {
    
        @AuraEnabled(cacheable=false)
        public static String recordRate(String isoCode, Double ConversionRate)
        {
           List<CurrencyType> thisCurrency = [
                        Select id
                        FROM CurrencyType 
                        WHERE IsoCode = :isoCode
                    ];
                            if(thisCurrency.size()<1) return 'no such CurrencyType ***'+ isoCode + '*** has been found';
                            Http h = new Http();
                    HttpRequest req = new HttpRequest();
            		req.setHeader('Authorization', '{!$Credential.OAuthToken}');
                    req.setEndpoint('callout:SalesforceRestApi/services/data/v54.0/sobjects/CurrencyType/' + thisCurrency[0].Id + '?_HttpMethod=PATCH' );
                    System.debug(req.getEndpoint());
                                    req.setBody('{ "ConversionRate" : ' + ConversionRate + '}');
                                    req.setHeader('Content-Type', 'application/json');
                                req.setMethod('POST');
                                HttpResponse res = h.send(req);
                          System.debug(res.toString());
                    return String.valueOf(res.getStatusCode());
        }
        
        
        @AuraEnabled(cacheable=false)
        public static Double getRate(String isoCode) {
            List<CurrencyType> rates = [
                SELECT ConversionRate
                FROM CurrencyType
                WHERE IsoCode = :isoCode
            ];
            if(rates.size()<1) {return -1;}
            return rates[0].ConversionRate;
        }
    
}