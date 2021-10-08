function(testName) {
	var test = testName.test;
    var FileInputStream = Java.type('java.io.FileInputStream');
    var currentDirectory = java.lang.System.getProperty('user.dir');
    var fis = new FileInputStream(currentDirectory +  '\\src\\main\\java\\resources\\global.properties');
    var prop = new java.util.Properties();
    var load = prop.load(fis);
    var propData = [];
    if(test==='soapTwoWay'){
    	propData[0] = prop.get('soapUrl');
    	propData[1] = prop.get('soapUserName');
    	propData[2] = prop.get('soapPassword');
    	propData[3] = prop.get('soapCustomerId');
    	propData[4] = prop.get('soapVehicleId');
    }
    else if(test==='restTwoWay'){
    	propData[0] = prop.get('restUrl');
    	propData[1] = prop.get('restUserName');
    	propData[2] = prop.get('restPassword');
    	propData[3] = prop.get('restCustomerId');
    	propData[4] = prop.get('restVehicleId');
    }
    
    return propData;
  }