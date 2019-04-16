package com.ebiz.cache;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import org.apache.log4j.Logger;

import com.ebiz.data.Config;
import com.ebiz.db.UtilDB;

public class ConfigDataProvider extends DataProvider
{
	static Logger logger = Logger.getLogger(ConfigDataProvider.class.getName());
	
    private static ConfigDataProvider s_instance = null;
    
    // instance variables
    private HashMap<String,String> map = null;

    protected ConfigDataProvider()
	throws Exception
    {
		logger.debug("StateDataProvider");
		load();
		logger.debug("StateDataProvider");
    }

    public void clear()
    {
    	map = new HashMap<String,String>();
    }



    public synchronized static void init()
	throws Exception
    {
		if (s_instance == null)
			s_instance = new ConfigDataProvider();
    }

    public static ConfigDataProvider getInstance() throws Exception
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
			logger.error("ConfigDataProvider::load",e);
		}
    }

    public void loadData() throws Exception
    {
    	map = UtilDB.getAllConfig();
    }

    public String getValue(String key)
    {
		return map.get(key);
    }
    
    public Config[] getValues()
    {
    	Config config;
    	ArrayList<Config> list = new ArrayList<Config>(map.size());
    	Set<String> set = map.keySet();
    	for(Iterator<String> iter = set.iterator(); iter.hasNext(); )
    	{
    		String key = iter.next();
    		config = new Config(key, map.get(key));
    		//Need to remove Shipped/Closed Status out of return Status or NOT
    		list.add(config);
    	}
    	
    	Config[] rets = new Config[list.size()];
		rets = list.toArray(rets);
		return rets;    	
    }
}