@isTest
public class CurencyRateRecorderTest {
    
    @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForCurrencyRecorder());
        String res = CurrencyRateRecorder.recordRate('USD',1);
        System.assertEquals('204', res); 
    }
}