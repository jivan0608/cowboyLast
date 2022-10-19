@isTest
global class MockHttpResponseForCFTest implements HttpCalloutMock  {
    
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"base": "USD",  "date": "2022-09-29",  "rates": {"EUR": 1.01965,"GBP": 0.90106}, "success": true, "timestamp": 1664484183}');
        res.setStatusCode(200);
        return res;
    }
    
    

}