package com.ebiz.web;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.PropertyConfigurator;

import com.ebiz.cache.ConfigDataProvider;
import com.ebiz.cache.EcryptoDataProvider;
import com.ebiz.cache.ShipperDataProvider;
import com.ebiz.cache.StateDataProvider;
import com.ebiz.cache.StatusCodeDataProvider;
import com.ebiz.cache.TrackerDataProvider;
import com.ebiz.cache.WoodCategoryDataProvider;
import com.ebiz.cache.WoodProductDataProvider;
import com.ebiz.job.TrackerScheduler;

public class InitServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	TrackerScheduler trackerThread = null;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		System.out.println("InitServlet::doPost:START");
		try {
			initLog4j();
			
			initDataProvider(config);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("InitServlet::doPost:END");
		}
	}
	
	public void destroy()
	{
		/*
		if( trackerThread != null )
		{
			while( trackerThread.isAlive() ){
				trackerThread.isContinue = false;
				trackerThread.setDaemon(true);
			}
		}
		*/
	}
	
	private void initLog4j(){
		String prefix = getServletContext().getRealPath("/");
		String file = getInitParameter("log4j-init-file");
		// if the log4j-init-file is not set, then no point in trying
		if (file != null) {
			PropertyConfigurator.configure(prefix + file);
		}else{
			System.out.println("*****WARNING: Can't INIT log4j, configuration file location is invalid");
		}
		
	}

	private void initDataProvider(ServletConfig config){
		try{	
			StateDataProvider.init();
			WoodCategoryDataProvider.init();
			WoodProductDataProvider.init();
			StatusCodeDataProvider.init();
			
			String key = config.getInitParameter("k");
			String scheme = config.getInitParameter("s");

			// System.out.println("key["+key+"] scheme["+scheme+"]");
			EcryptoDataProvider.init(key, scheme);
			ConfigDataProvider.init();
			
			ShipperDataProvider.init();
			
			//starting tracker
			TrackerDataProvider.init();
			trackerThread = new TrackerScheduler();
			//daemon thread will allow tomcat to shutdown successfully.  Otherwise active thread will block tomcat shutdown session!
			trackerThread.setDaemon(true);
			trackerThread.start();
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
	}
}