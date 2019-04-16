package com.ebiz.cache;

import java.util.ArrayList;

public class LoggerDataProvider extends DataProvider
{
    private static LoggerDataProvider s_instance = null;
    
    ArrayList<String> list = null;

    // instance variables

    protected LoggerDataProvider()
    {
		load();
    }

    public void clear()
    {
    	list = null;
    }



    public synchronized static void init()
    {
		if (s_instance == null){
			s_instance = new LoggerDataProvider();
		}
    }

    public static LoggerDataProvider getInstance()
    {
		if( s_instance == null )
			init();

		return s_instance;
    }



    public void load()
    {
		try{
			register();
			clear();
			loadData();
		}
		catch (Exception e){
			e.printStackTrace();
		}
    }

    public void loadData()
    {
    	list = new ArrayList<String>();
    }
    
    public void debug(String data)
    {
    	list.add(data);
    }

    public ArrayList<String> getData()
    {
		return list;
    }
}