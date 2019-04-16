package com.ebiz.cache;

import java.util.HashMap;

import com.ebiz.data.Status;
import com.ebiz.db.ReferenceDB;

public class StatusCodeDataProvider extends DataProvider
{
    private static StatusCodeDataProvider s_instance = null;
    
    // instance variables
    private HashMap<String,Status> map = null;

    protected StatusCodeDataProvider()
	throws Exception
    {
		//Trace.begin("StateDataProvider");
		load();
		//Trace.end("StateDataProvider");
    }

    public void clear()
    {
    	map = new HashMap<String,Status>();
    }



    public synchronized static void init()
	throws Exception
    {
		if (s_instance == null)
			s_instance = new StatusCodeDataProvider();
    }

    public static StatusCodeDataProvider getInstance() throws Exception
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
    	Status[] status = ReferenceDB.getAllStatuses();
    	for( int i=0; i<status.length; i++ ){
    		map.put(status[i].getCode(), status[i]);
    	}
    }

    public Status getStatus(String code)
    {
		return map.get(code);
    }
}