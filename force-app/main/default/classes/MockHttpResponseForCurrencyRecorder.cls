@isTest
global class MockHttpResponseForCurrencyRecorder implements HttpCalloutMock {
     global HTTPResponse respond(HTTPRequest req) {  
        System.assertEquals('POST', req.getMethod());
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setStatusCode(204);
        System.debug('inside mock, res = ' + res.getStatusCode());
        return res;
    }

}