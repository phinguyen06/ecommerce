package com.ebiz.cache;

import com.ebiz.data.State;
import com.ebiz.db.ReferenceDB;

public class StateDataProvider extends DataProvider
{
    private static StateDataProvider s_instance = null;

    // instance variables
    private State[] states  = null;

    protected StateDataProvider()
	throws Exception
    {
		//Trace.begin("StateDataProvider");
		load();
		//Trace.end("StateDataProvider");
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
			//Trace.logException("StateDataProvider::load",e);
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