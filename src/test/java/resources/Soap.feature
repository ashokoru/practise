@Soap
@parallel=false
Feature: Test Soap APIs Production  

Background:

  * def data = call read('PropFiles.js') { test: 'soapTwoWay' }

	* url data[0]
	* configure ssl = true
	* configure cookies = null
	* def APIurl = data[0]
	* def userName = data[1]
	* def password = data[2]
	* def customerId = data[3]
	* def vehicleId = data[4]

* configure headers = {Content-Type: 'application/xml'}
* header Authorization = call read('basic-auth.js') { username: '#(userName)', password: '#(password)' }
* path 'Command'

* def result =
	"""
	function(pause){
	java.lang.Thread.sleep(pause)

	}
	"""

@ignore @requestStatus
Scenario: Request Status

* def resu = call result 32000

* def myrequestID =
    """
    {
    requestIdentifier: '#(requestIdentifier)'
    }
    """
Given request
"""
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    <soapenv:Header/>
    <soapenv:Body>
        <ser:getRequestStatus>
            <!--1 or more repetitions:-->
            <RequestStatuses>
                <customerId>#(customerId)</customerId>
                <requestReference>#(requestIdentifier)</requestReference>
                <vehicleId>#(vehicleId)</vehicleId>
            </RequestStatuses>
            <operatorName>?</operatorName>
        </ser:getRequestStatus>
    </soapenv:Body>
</soapenv:Envelope>

"""

When soap action ''
Then status 200
And print response


Scenario Outline: Update Set Point zone <Zone>
Given request
"""
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    <soapenv:Header/>
    <soapenv:Body>
        <ser:updateSetPoint>
            <!--1 or more repetitions:-->
            <customerVehicles>
                <customerid>#(customerId)</customerid>
                <!--1 or more repetitions:-->
                <vehicles>#(vehicleId)</vehicles>
            </customerVehicles>
            <zoneId><Zone></zoneId>
            <setPointValue><SP Value></setPointValue>
        </ser:updateSetPoint>
    </soapenv:Body>
</soapenv:Envelope>
"""
When soap action ''
Then status 200
And print response
And match response /Envelope/Body/updateSetPointResponse/requestReference/customerId == customerId
* def requestIdentifier = /Envelope/Body/updateSetPointResponse/requestReference/requestIdentifier
Then print requestIdentifier
* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}

Examples:
|Zone|SP Value|
|1	 |-2			|
#|2	 |-24			|
#|3   |-11			|

#
#Scenario: Clear All Alarms
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:clearAlarms>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<operatorName>?</operatorName>
        #</ser:clearAlarms>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/clearAlarmsResponse/requestReferences/customerId == customerId
#* def requestIdentifier = /Envelope/Body/clearAlarmsResponse/requestReferences/requestIdentifier
#Then print requestIdentifier
#* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}
#
#
#Scenario: Perform Pre Trip
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:performPreTrip>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<operatorName>?</operatorName>
        #</ser:performPreTrip>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/performPreTripResponse/requestReference/customerId == customerId
#* def requestIdentifier = /Envelope/Body/performPreTripResponse/requestReference/requestIdentifier
#Then print requestIdentifier
#* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}
#
#
#Scenario Outline: Defrost	<Zone>
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:defrost>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<zoneId><Zone></zoneId>
            #<operatorName>?</operatorName>
        #</ser:defrost>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/defrostResponse/requestReference/customerId == customerId
#* def requestIdentifier = /Envelope/Body/defrostResponse/requestReference/requestIdentifier
#Then print requestIdentifier
#* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}
#
#Examples:
#|Zone|
#|1   |
#|2   |
#|3   |
#
#
#Scenario Outline: <OP Mode> Mode
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:enter<OP Mode>>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<operatorName>?</operatorName>
        #</ser:enter<OP Mode>>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/enter<OP Mode>Response/requestReference/customerId == customerId
#* def requestIdentifier = /Envelope/Body/enter<OP Mode>Response/requestReference/requestIdentifier
#Then print requestIdentifier
#* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}
#
#Examples:
#|OP Mode        |
#|ContinuousMode |
#|CycleSentryMode|
#
#
#Scenario: Configure Temperature Settings
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:configureTemperatureRangeSettings>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<settings>
                #<zoneId>1</zoneId>
                #<highTemperature>10</highTemperature>
                #<lowTemperature>-10</lowTemperature>
                #<rangeRelativeTo>1</rangeRelativeTo>
                #<outOfRange>10</outOfRange>
            #</settings>
            #<operatorName>?</operatorName>
        #</ser:configureTemperatureRangeSettings>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/configureTemperatureRangeSettingsResponse/requestReference/customerId == customerId
#* def requestIdentifier = /Envelope/Body/configureTemperatureRangeSettingsResponse/requestReference/requestIdentifier
#Then print requestIdentifier
#* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}
#
#
#Scenario: View Temperature Settings
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:viewTemperatureRangeSettings>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<operatorName>?</operatorName>
        #</ser:viewTemperatureRangeSettings>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/viewTemperatureRangeSettingsResponse/TemperatureRangeSettings/customerId == customerId
#
#
#Scenario: View Optiset Profile
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:viewOptisetProfile>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<operatorName>?</operatorName>
        #</ser:viewOptisetProfile>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/viewOptisetProfileResponse/OptisetProfile/customerId == customerId
#
#
#Scenario: Activate Optiset Profile
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:activateOptisetProfile>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<profile_id>625295551</profile_id>
            #<setPoint>-23</setPoint>
            #<language>1</language>
            #<operatorName>?</operatorName>
        #</ser:activateOptisetProfile>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/activateOptisetProfileResponse/requestReference/customerId == customerId
#* def requestIdentifier = /Envelope/Body/activateOptisetProfileResponse/requestReference/requestIdentifier
#Then print requestIdentifier
#* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}
#
#
#Scenario: Configure Door Alarm
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:configureDoorAlarm>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<!--1 or more repetitions:-->
            #<settings>
                #<dwellTime>20</dwellTime>
                #<zoneId>1</zoneId>
            #</settings>
            #<operatorName>?</operatorName>
        #</ser:configureDoorAlarm>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/configureDoorAlarmResponse/requestReference/customerId == customerId
#* def requestIdentifier = /Envelope/Body/configureDoorAlarmResponse/requestReference/requestIdentifier
#Then print requestIdentifier
#* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}
#
#
#Scenario: View Door Alarm
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:viewDoorAlarm>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repeti+E13:E15tions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<operatorName>?</operatorName>
        #</ser:viewDoorAlarm>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/viewDoorAlarmResponse/requestReference/status == 'true'
#
#
#Scenario: Remote Off
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:remoteOff>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<operatorName>?</operatorName>
        #</ser:remoteOff>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/remoteOffResponse/requestReference/customerId == customerId
#* def requestIdentifier = /Envelope/Body/remoteOffResponse/requestReference/requestIdentifier
#Then print requestIdentifier
#* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}
#
#
#
#Scenario: Get Temperature Data
#
#* def getDate =
  #"""
  #function() {
    #var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
    #var sdf = new SimpleDateFormat('yyyy-MM-dd');
    #var date = new java.util.Date();
    #return sdf.format(date);
  #} 
  #"""
#* def currentDate = getDate()
#* def startTime = currentDate + 'T00:00:00'
#* def endTime = currentDate + 'T10:05:00'
#
#Given path 'Data'
#And request
#"""
#<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soap:Header/>
    #<soap:Body>
        #<ser:getTemperatureDataForVehicles>
            #<!--Optional:-->
            #<customerReferenceId>#(customerId)</customerReferenceId>
            #<!--Optional:-->
            #<startTime>#(startTime)</startTime>
            #<!--Optional:-->
            #<endTime>#(endTime)</endTime>
        #</ser:getTemperatureDataForVehicles>
    #</soap:Body>
#</soap:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#
#
#Scenario: Remote On
#Given request
#"""
#<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.jbossws.webservices.celtrak.com/">
    #<soapenv:Header/>
    #<soapenv:Body>
        #<ser:remoteOn>
            #<!--1 or more repetitions:-->
            #<customerVehicles>
                #<customerid>#(customerId)</customerid>
                #<!--1 or more repetitions:-->
                #<vehicles>#(vehicleId)</vehicles>
            #</customerVehicles>
            #<operatorName>?</operatorName>
        #</ser:remoteOn>
    #</soapenv:Body>
#</soapenv:Envelope>
#"""
#When soap action ''
#Then status 200
#And print response
#And match response /Envelope/Body/remoteOnResponse/requestReference/customerId == customerId
#* def requestIdentifier = /Envelope/Body/remoteOnResponse/requestReference/requestIdentifier
#Then print requestIdentifier
#* def myrequestID = call read('Soap.feature@requestStatus') {requestIdentifier : '#(requestIdentifier)'}