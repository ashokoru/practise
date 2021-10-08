@report=false
@AuthToken @ignore
Feature: Authorization token for APIs

Scenario: Generate auth token

* def obtainToken =
    """
    {
    APIurl : '#(APIurl)', userName : '#(userName)', password : '#(password)', customerId : '#(customerId)'
    }
    """
    Then print obtainToken
    * url APIurl

Given path 'connected-solutions/obtainToken/'
And header X-External-ID = customerId
And body= {"userName": userName,"password": password}
And request body
When method post
Then status 200
* def authToken = response.accessToken
Then print authToken