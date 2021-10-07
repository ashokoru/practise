@report=false
@RequestStatus @ignore
Feature: Request Status for two way commands

Background:

	* def result =
	"""
	function(pause){
	java.lang.Thread.sleep(pause)

	}
	"""

@requestStatus
Scenario: Get Request Status

* def resu = call result 40000
#* url 'https://rest.tracking.thermoking.com/'

* def myrequestID =
    """
    {
    APIurl : '#(APIurl)', requestAPIName: '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'
    }
    """     
Then print myrequestID
And print requestRefUpdateSetPoint

* url APIurl
Given path 'connected-solutions/getRequestStatus/'
And header X-OAUTH2-Token = authToken
And header X-External-ID = customerId
And param vehicles = vehicleId
And body= [{"customerId": customerId,"vehicleId": vehicleId,"requestReference": requestAPIName}]
And request body
When method post
Then status 200
And print response
And match response[0].externalCustomerId == customerId
#And match response[0].externalVehicleid == vehicleId