public class CurrencyRefresher implements Schedulable{
     
    		Credentials_Storage__mdt storage = Credentials_Storage__mdt.getInstance('CurrencyUpdater');
     		//String apiKey = 'wdDBDMxafdbuY3y2aiSgpSlyt7rnq8DA';
     		//String endPoint = 'https://api.apilayer.com/exchangerates_data/latest?symbols=<SYMBOLS>&base=<BASE>';
     		String apiKey = storage.apikey__c;
         	String endPoint = storage.URL__c;

    
    public void execute(SchedulableContext ctx) {
       	Map<String,Double> isoCodeToConversionRateMap = getIsoCodeToConversionRateMap(getCorporateIsoCode(),getIsoCodes());                   
        recordRates(isoCodeToConversionRateMap);
    }
            
    
    public String getCorporateIsoCode(){
       		CurrencyType corporate = [
            SELECT Id, IsoCode
            FROM CurrencyType
            WHERE isActive = TRUE AND isCorporate = TRUE
        ];	
        return corporate.IsoCode;       
    }
    
    public List<CurrencyType> getOrgCurrencies(){
        List<CurrencyType> currencies = [
            SELECT Id, ConversionRate,IsoCode
            FROM CurrencyType
            WHERE isActive = TRUE AND isCorporate = FALSE
        ];
        return currencies;
    }
    
    public List<String> getIsoCodes(){
        List<String> isoCodes = new List<String>();
        for (CurrencyType actualCurrency : getOrgCurrencies()) {
            isoCodes.add(actualcurrency.isoCode);
        }
        return isoCodes;        
    }
    
    public Map<String,Double> getIsoCodeToConversionRateMap(String corporateCurrency, List<String> isoCodes) {
        Map<String,Double> isoCodeToConversionRateMap = new Map<String,Double>();
        Http h = new HTTP();
        HttpRequest request = new HttpRequest();
        String endPointWithHeaders = endpoint.replace('<SYMBOLS>', String.join(isoCodes, ',')).replace('<BASE>',corporateCurrency);
        request.setEndpoint(endPointWithHeaders);
        request.setMethod('GET');
        request.setHeader('apikey', apikey);
        HttpResponse response = h.send(request);
        System.debug(response.getBody());
        try{
        Map<String, Object> resultMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        System.debug(resultMap.get('rates'));
		Map<String, Object> resultIsoCodetoRateMap = (Map<String, Object>) resultMap.get('rates');
            for(String isoCode: resultIsoCodetoRateMap.keySet()){
                isoCodeToConversionRateMap.put(isoCode, double.valueOf(resultIsoCodetoRateMap.get(isoCode)));
            }
        		isoCodeToConversionRateMap.put(corporateCurrency,1);
            } catch(TypeException e) {
                System.debug('Error during conversion rates desiarialization: ' + e.getMessage());
            }
        System.debug('isoCodeToConversionRateMap : ' + isoCodeToConversionRateMap);
        return isoCodeToConversionRateMap;
    }
    
    public String recordRates(Map<String,Double> isoCodeToConversionRateMap){
        String overallStatus = '204';
        for(String isoCode: isoCodeToConversionRateMap.keySet())
        {
            String status = CurrencyRateRecorder.recordRate(isoCode,isoCodeToConversionRateMap.get(isoCOde));
            if (status !='204') {
                overallStatus = status;
            }     
        }      
			return overallStatus;        
    }
    

}