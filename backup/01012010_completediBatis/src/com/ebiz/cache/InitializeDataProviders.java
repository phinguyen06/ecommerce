package com.ebiz.cache;

//import org.apache.log4j.PropertyConfigurator;

public class InitializeDataProviders {
	public static void init() throws Exception
	{
		System.out.println("InitializeDataProviders");
		/*
		try{
			PropertyConfigurator.configure("/home/content/e/b/i/ebizdeal09/html/gifts/WEB-INF/classes/log4j.lcf");
		}
		catch(Exception e){
			System.out.println("*****WARNING: Can't INIT log4j, configuration file location is invalid");
		}
		*/
			
		StateDataProvider.init();
		WoodCategoryDataProvider.init();
		WoodProductDataProvider.init();
		StatusCodeDataProvider.init();
		
		String key = "ZUJpeiBpcyBhIGdsb2JhbCB0cmFkaW5nIGNvbXBhbnkgZm9yIGJvdGggaW1wb3J0IGFuZCBleHBvcnQ=";
		String scheme = "REVT";
	
		EcryptoDataProvider.init(key, scheme);
		ConfigDataProvider.init();
		
		ShipperDataProvider.init();
		TransactionDataProvider.init();  //background jobs to process order update, email notification
		TrackerDataProvider.init();		//background jobs to track page hits from web users
		
		LoggerDataProvider.init();
	}
}
