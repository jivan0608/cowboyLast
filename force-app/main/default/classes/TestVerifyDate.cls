@isTest
private class TestVerifyDate {
    
    @isTest static void checkWithIn() {
        Date date1 = Date.newInstance(1985,6,6);
        Date date2 = Date.newInstance(1985,6, 16);
        Date resultDate = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, resultDate);
        
    }
    
    
    @isTest static void checkPast() {
        Date date1 = Date.newInstance(1985,6,6);
        Date date2 = Date.newInstance(1985,6, 4);
        Date endDate  = Date.newInstance(1985,6, 30);
        Date resultDate = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(endDate, resultDate);
        
    }
    
    @isTest static void checkMore30() {
        Date date1 = Date.newInstance(1985,6,6);
        Date date2 = Date.newInstance(1985,7, 25);
        Date endDate  = Date.newInstance(1985,6, 30);
        Date resultDate = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(endDate, resultDate);
        
    }
    
    

}