package Karate.KarateScripts;

import static org.junit.Assert.assertTrue;     


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import org.apache.commons.io.FileUtils;
//import org.junit.Test;
import org.junit.runner.RunWith;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Test;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import cucumber.api.CucumberOptions;
import net.masterthought.cucumber.ReportBuilder;

//@RunWith(Karate.class)
@KarateOptions(tags = {"~@ignore", "@Soap"}, features = "classpath:resources")
public class APIRunnerTest1 {
	
	@BeforeSuite
	public void beforeTest() {
		System.out.println("This is before suite");
		File dir = new File(System.getProperty("user.dir")+"\\target\\surefire-reports");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("ddMMyyyy_hhmmss");
		Date date = new Date();
		String currentDate = dateFormat.format(date);
		File[] filesList = dir.listFiles();
		File destDir = new File(System.getProperty("user.dir")+"\\target\\surefire-reports-backup\\"+currentDate);
		for(File file : filesList) {
			if(file.exists()) {
				System.out.println(file);
				destDir.mkdir();
				file.renameTo(new File(destDir+"\\"+file.getName()));
			}
		}
	}
		
	@Test
	public void parallelRun() {
		
        Results results=Runner.parallel(getClass(),5);
        generateReport(results.getReportDir());
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);     
		System.out.println("Parallel Run");
    }
     
    public static void generateReport(String karateOutputPath) {        
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        final List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        SimpleDateFormat format = new SimpleDateFormat("ddMMyyyy_hhmmss");
        Date date = new Date();
        String currentDate = format.format(date);
        Configuration config = new Configuration(new File("Target\\CucumberReports\\"+currentDate), "TK API Testing");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();        
    }

}
