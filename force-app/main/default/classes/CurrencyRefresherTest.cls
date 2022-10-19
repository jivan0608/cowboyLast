@Istest public class CurrencyRefresherTest {
    
    @isTest public static void getCorporateIsoCodeTest() {
        CurrencyRefresher currencyRefresher = new CurrencyRefresher();
        String res = currencyRefresher.getCorporateIsoCode();
        System.assertEquals('USD', res);
    } 
    
    @isTest public static void getOrgCurrenciesTest(){
        	CurrencyRefresher currencyRefresher = new CurrencyRefresher();
        	List<CurrencyType> currencies = currencyRefresher.getOrgCurrencies();
            System.assertEquals(currencies.size(), 2);
            Set<String> isoCodes = new Set<String>();
        for (CurrencyType currenc: currencies) {
            isoCodes.add(currenc.IsoCode);
        }
        	System.assert(isoCodes.contains('GBP'));
        	System.assert(isoCodes.contains('EUR'));	          
        }
        
    @isTest public static void getIsoCodesTest(){
         	CurrencyRefresher currencyRefresher = new CurrencyRefresher();
        	List<String> isoCodes = currencyRefresher.getIsoCodes();
         	System.assertEquals(isoCodes.size(),2);
        	System.assert(isoCodes.contains('GBP'));
        	System.assert(isoCodes.contains('EUR'));
        
    }
    
    @isTest public static void getIsoCodeToConversionRateMapTest(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForCFTest());
        CurrencyRefresher currencyRefresher = new CurrencyRefresher();
        
        Map<String,Double> isoCodeToConversionRateMap = currencyRefresher.getIsoCodeToConversionRateMap('USD', new List<String>{'GBP','EUR'});
        System.assertEquals(isoCodeToConversionRateMap.size(),3);
        System.assertEquals(isoCodeToConversionRateMap.get('USD'), 1);
        System.assertEquals(isoCodeToConversionRateMap.get('EUR'), 1.01965);
        System.assertEquals(isoCodeToConversionRateMap.get('GBP'), 0.90106);
        
    }
    
     @isTest public static void recordRatesTest()
     {
         CurrencyRefresher currencyRefresher = new CurrencyRefresher();
          	Test.setMock(HttpCalloutMock.class, new MockHttpResponseForCurrencyRecorder());
         	Map<String,Double> isoCodeToConversionRateMap = new Map<String,Double>();
         	isoCodeToConversionRateMap.put('USD',1);
        	String res = currencyRefresher.recordRates(isoCodeToConversionRateMap);
         	System.assertEquals('204',res);
     
     }
    
        
    }