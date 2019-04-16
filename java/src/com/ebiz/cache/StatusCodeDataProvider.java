package com.ebiz.cache;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import org.apache.log4j.Logger;

import com.ebiz.data.Constants;
import com.ebiz.data.Status;
import com.ebiz.db.ReferenceDB;

public class StatusCodeDataProvider extends DataProvider
{
	static Logger logger = Logger.getLogger(StatusCodeDataProvider.class.getName());
	
    private static StatusCodeDataProvider s_instance = null;
    
    // instance variables
    private HashMap<String,Status> map = null;

    protected StatusCodeDataProvider()
	throws Exception
    {
		logger.debug("StatusCodeDataProvider");
		load();
		logger.debug("StatusCodeDataProvider");
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
			logger.error("StatusCodeDataProvider::load",e);
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
    
    public Status[] getStatuses(boolean isIncludeCompleted)
    {
    	ArrayList<Status> list = new ArrayList<Status>();
    	Set<String> set = map.keySet();
    	for(Iterator<String> iter = set.iterator(); iter.hasNext(); )
    	{
    		String key = iter.next();
    		//Need to remove Shipped/Closed Status out of return Status or NOT
    		if( !isIncludeCompleted && String.valueOf(Constants.s_ORDER_SHIPPED_CODE).equals(key))
    			continue;
    		list.add(map.get(key));
    	}
    	
    	Status[] rets = new Status[list.size()];
		rets = list.toArray(rets);
		return rets;    	
    }
}