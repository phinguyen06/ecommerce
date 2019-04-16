package com.ebiz.job;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ebiz.cache.ConfigDataProvider;
import com.ebiz.cache.TrackerDataProvider;
import com.ebiz.data.Constants;
import com.ebiz.data.Tracker;
import com.ebiz.db.UtilDB;

public class TrackerScheduler extends Thread{
	static Logger logger = Logger.getLogger(TrackerScheduler.class.getName());
	
	public boolean isContinue = true;
	
	public TrackerScheduler(){
		
	}
	
	/**
	 * run - overwrite the default thread run method with our implementation
	 */
	public void run()
	{
		logger.debug("TrackerScheduler::run:START");
		try
		{
			Tracker tracker;
			TrackerDataProvider trackerDP = TrackerDataProvider.getInstance();
			ArrayList<Tracker> list;
			while(isContinue)
			{ 
				logger.debug("TrackerScheduler::run:scheduler running");
				list = trackerDP.getTrackers();
				if( list != null )
				{
					//logger.debug("TrackerScheduler::run:list is not empty: " + list.size());
					while( list.size() > 0 ){
						tracker = list.remove(0);
						UtilDB.insertTracker(tracker);
					}
				}
				sleep(Integer.parseInt(ConfigDataProvider.getInstance().getValue(Constants.s_CONFIG_SCHEDULER_TRACKER_SLEEP_TIME)));
			}
			
		}
		catch(Exception e)
		{
			logger.error(e.toString());
		}
		finally{
			logger.debug("TrackerScheduler::run:END");
		}
	}
}
