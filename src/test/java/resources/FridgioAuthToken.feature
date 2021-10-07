@ignore
@report=false
@FridgioAuthToken
Feature: Authorization token for APIs

Background:
	* url 'https://restdev1.tracking.thermoking.com/'

Scenario: Generate auth token
Given path 'connected-solutions/GetAuthToken/'
And header X-External-ID = '5-UUvQsTkfI'
And body= {"userName": "webservice.usertp01@demosystem.com","password": "Pass@1234"}
And request body
When method post
#Then status 200
* def authToken = response.accessToken
Then print authToken