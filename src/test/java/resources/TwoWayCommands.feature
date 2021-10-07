@Two_Way_Commands @ignore
@parallel=false
Feature: TwoWayCommands

Background:

  * def data = call read('PropFiles.js') { test: 'restTwoWay' }

	* url data[0]
	* configure ssl = true
	* configure cookies = null
	* def APIurl = data[0]
	* def userName = data[1]
	* def password = data[2]
	* def customerId = data[3]
	* def vehicleId = data[4]
	* configure headers = {X-External-ID: '#(customerId)'}
	* def requestBody = {"userName": '#(userName)',"password": '#(password)'}
	* params {vehicles: '#(vehicleId)'}
	* def obtainToken = callonce read('TokenTwoWay.feature') {APIurl : '#(APIurl)', userName : '#(userName)', password : '#(password)', customerId : '#(customerId)'}
	* def authToken = obtainToken.response.accessToken
	Then print authToken
	* def result =
	"""
	function(pause){
	java.lang.Thread.sleep(pause)

	}
	"""
	
Scenario: Update Set Point

Given path 'connected-solutions/updateSetPoint/'
And param zone = '1'
And param setpoint = '2'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
And print authToken
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}


Scenario: Perform Pre Trip

Given path 'connected-solutions/performPreTrip/'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}


Scenario: Cycle Sentry Mode

Given path 'connected-solutions/enterCycleSentryMode/'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}

Scenario: Continuous Mode

Given path 'connected-solutions/enterContinuousMode/'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}

Scenario: Defrost

Given path 'connected-solutions/defrost/'
And header X-OAUTH2-Token = authToken
And param zone = '1'
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}

Scenario: Clear Alarms

Given path 'connected-solutions/clearAlarms/'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}


Scenario: View Optiset Profile

Given path 'connected-solutions/viewOptisetProfile/'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#	null'
* def resu = call result 40000


Scenario: Activate Optiset Profile

Given path 'connected-solutions/activateOptisetProfile/'
And header X-OAUTH2-Token = authToken
And params {"profileId": "625295551","setpoint": "-23","languageId": "1"}
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}


Scenario: Configure Door Alarm

Given path 'connected-solutions/configureDoorAlarm/'
And header X-OAUTH2-Token = authToken
And body= [{"zoneId":"1","dwellTime":"30"}]
And request body
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}

Scenario: Configure Temperature Range Settings

Given path 'connected-solutions/configureTemperatureRangeSettings/'
And header X-OAUTH2-Token = authToken
And body= [{"zoneId": "1","highTemperature": "30","lowTemperature": "-30","rangeRelativeTo": "1","outOfRange": "10"}]
And request body
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}

Scenario: View Door Alarm

Given path 'connected-solutions/viewDoorAlarm/'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response == [{"doorAlarmDwellingMins1": 30,"doorAlarmDwellingMins2": 0,"doorAlarmDwellingMins3": 0,"vehicleName": '#(vehicleId)',"customerName": '#(customerId)',"status": true}]
* def resu = call result 40000

Scenario: View Temperature Range Settings

Given path 'connected-solutions/viewTemperatureRangeSettings/'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].lowTemperatureZone1 == -30
And match response[0].highTemperatureZone1 == 30
And match response[0].rangeRelativeZone1 == 1
And match response[0].outOfRangeTimeZone1 == 10
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].status == true
* def resu = call result 40000

Scenario: Remote Off

Given path 'connected-solutions/remoteOff/'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}
* def resu = call result 40000


Scenario: Get Temperature Data for vehicles

* def getDate =
  """
  function() {
    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
    var sdf = new SimpleDateFormat('yyyy-MM-dd');
    var date = new java.util.Date();
    return sdf.format(date);
  } 
  """
* def currentDate = getDate()
* def startTime = currentDate + ' 00:00:00'
* def endTime = currentDate + ' 10:05:00'
* def pathId = 'connected-solutions/getTemperatureDataForVehicles/' + startTime + '/' + endTime + '/'

Given path pathId

And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
When method get
Then status 200
And print response
And match response[0].vehicleName == '#notnull'
* def resu = call result 40000


Scenario: Remote On

Given path 'connected-solutions/remoteOn/'
And header X-OAUTH2-Token = authToken
And body= {"userName": '#(userName)',"password": '#(password)'}
And request requestBody
When method post
Then status 200
And print response
And match response[0].customerId == customerId
And match response[0].vehicleId == vehicleId
And match response[0].requestIdentifier == '#notnull'
* def requestAPIName = response[0].requestIdentifier
Then print requestAPIName
* def myrequestID = call read('GetRequestStatus.feature@requestStatus') {APIurl : '#(APIurl)', requestAPIName : '#(requestAPIName)', authToken : '#(authToken)', customerId : '#(customerId)', vehicleId : '#(vehicleId)'}


