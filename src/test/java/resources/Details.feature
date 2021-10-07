@ignore

Feature: fetching User Details
Scenario: testing the get call for User Details
 
Given url 'https://comtable.free.beeceptor.com'
When method GET
Then status 200
Given expectedResult=read('./resources/Expected.json')
Given def expectedResultParam = expectedResult[0]
And match response[1] == expectedResultParam
And match response[0] == expectedResultParam