package com.ebiz.cache;

import org.apache.log4j.Logger;

import com.ebiz.data.State;
import com.ebiz.db.ReferenceDB;

public class StateDataProvider extends DataProvider
{
	static Logger logger = Logger.getLogger(StateDataProvider.class.getName());
	
    private static StateDataProvider s_instance = null;

    // instance variables
    private State[] states  = null;

    protected StateDataProvider()
	throws Exception
    {
		logger.debug("StateDataProvider");
		load();
		logger.debug("StateDataProvider");
    }

    public void clear()
    {
    	states = null;
    }



    public synchronized static void init()
	throws Exception
    {
		if (s_instance == null)
			s_instance = new StateDataProvider();
    }

    public static StateDataProvider getInstance() throws Exception
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
			logger.error("StateDataProvider::load",e);
		}
    }

    public void loadData() throws Exception
    {
    	states = ReferenceDB.getStates("USA");
    }

    public State[] getStates()
    {
		return states;
    }
}