@report=false
@Fridgio @parallel=false

Feature: fridgio post

Background:
	* url 'https://restdev1.tracking.thermoking.com/'
	* configure ssl = true
	* def newp = 'aa'
	* configure headers = {X-External-ID: '5-UUvQsTkfI'}
	* def obtainToken = callonce read('FridgioAuthToken.feature')
	* def accToken = obtainToken.response.accessToken
	Then print accToken


#Scenario: send fridgio API
#
#
#* configure ssl = true
#Given url 'https://10.200.107.51/connected-solutions/obtainToken/'
#And header X-External-ID = '52D0B083-E9B7-47F6-9BAA-D22951DD1E50'
#And body= {"userName": "webservice.user3416@demosystem.com","password": "Pass@1234"}
#And request body
#When method post
#Then status 200
#And match response.accessToken == 

#@tag1
Scenario: Test Sample scenario
* def newp = 'data'
Then print newp

Scenario: Get TP Customer Details

Given header X-OAUTH2-Token = accToken
Then print accToken
* def res = call read('DetailsPost.feature@tag1')
Then print res.result
Given path 'connected-solutions/GetCarrierVehicleList/'
And param externalCarrierId = '52D0B083-E9B7-47F6-9BAA-D22951DD1E50'
And body= {"userName": "webservice.usertp01@demosystem.com","password": "Pass@1234"}
And request body
When method post
Then status 200
And print response
And match response[*].vehicleExternalId contains ['1100295']

@TripStart
Scenario: Update Vehicle Trip Start

Given header X-OAUTH2-Token = accToken
Then print accToken
Given path 'connected-solutions/StartTrip/'
And param externalCarrierId = '52D0B083-E9B7-47F6-9BAA-D22951DD1E50'
And param vehicleExtId = '1100295'
And param scheduledStartTime = '2021-05-19 09:00:00'
And param scheduledDeliveryTime = '2021-05-19 09:00:00'
And param commodity = ''
And body= {"userName": "webservice.usertp01@demosystem.com","password": "Pass@1234"}
And request body
When method post
Then status 200
And print response
And match response.tripStatus == 'STARTED'
And match response.tripStopTime == null
And match response.isTripActive == 1
#
#@VehicleData
#Scenario: Get TP Vehicle data
#
#* def res = call read('DetailsPost.feature@TripStart')
#Then print res.result
#
#Given header X-OAUTH2-Token = accToken
#Then print accToken
#Given path 'connected-solutions/GetVehicleTemperatureData/'
#And param externalCarrierId = '52D0B083-E9B7-47F6-9BAA-D22951DD1E50'
#And param vehicleExtId = '1100295'
#And param startDate = '2021-02-05 09:00:00'
#And body= {"userName": "webservice.usertp01@demosystem.com","password": "Pass@1234"}
#And request body
#* def result =
#"""
#function(pause){
#java.lang.Process = new java.lang.ProcessBuilder("C:\\Users\\irgigt\\Desktop\\celtrak.exe").start();
#java.lang.Thread.sleep(pause)
#
#}
#"""
#* def resu = call result 30000
#When method post
#Then status 200
#And print response
#And print resu
#
#
#Scenario: Update Vehicle Trip Stop
#
#* def res = call read('DetailsPost.feature@VehicleData')
#Then print res.result
#
#Given header X-OAUTH2-Token = accToken
#Then print accToken
#Given path 'connected-solutions/StopTrip/'
#And param externalCarrierId = '52D0B083-E9B7-47F6-9BAA-D22951DD1E50'
#And param vehicleExtId = '1100295'
#And body= {"userName": "webservice.usertp01@demosystem.com","password": "Pass@1234"}
#And request body
#When method post
#Then status 200
#And print response
#And match response.tripStatus == 'STOPPED'
#And match response.isTripActive == 0
#
#
#
