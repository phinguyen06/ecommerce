package com.ebiz.cache;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ebiz.data.Tracker;

public class TrackerDataProvider extends DataProvider
{
	static Logger logger = Logger.getLogger(TrackerDataProvider.class.getName());
	
    private static TrackerDataProvider s_instance = null;
    
    ArrayList<Tracker> list = null;

    // instance variables

    protected TrackerDataProvider()
	throws Exception
    {
		logger.debug("TrackerDataProvider");
		load();
		//Start Tracker timer thread to insert data into DB on the background
		logger.debug("TrackerDataProvider");
    }

    public void clear()
    {
    	list = null;
    }



    public synchronized static void init()
	throws Exception
    {
		if (s_instance == null)
			s_instance = new TrackerDataProvider();
    }

    public static TrackerDataProvider getInstance() throws Exception
    {
		if( s_instance == null )
			init();

		return s_instance;
    }



    public void load() throws Exception
    {
		try{
			register();
			clear();
			loadData();
		}
		catch (Exception e){
			logger.error("TrackerDataProvider::load",e);
		}
    }

    public void loadData() throws Exception
    {
    	list = new ArrayList<Tracker>();
    }
    
    public void addTracker(Tracker tracker)
    {
    	list.add(tracker);
    }

    public ArrayList<Tracker> getTrackers()
    {
		return list;
    }
}