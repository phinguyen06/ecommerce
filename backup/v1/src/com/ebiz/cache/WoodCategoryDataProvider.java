package com.ebiz.cache;

import com.ebiz.data.WoodCategory;
import com.ebiz.db.WoodDB;

public class WoodCategoryDataProvider extends DataProvider
{
    private static WoodCategoryDataProvider s_instance = null;

    // instance variables
    private WoodCategory[] categories  = null;

    protected WoodCategoryDataProvider()
	throws Exception
    {
		//Trace.begin("WoodCategoryDataProvider");
		load();
		//Trace.end("WoodCategoryDataProvider");
    }

    public void clear()
    {
    	categories = null;
    }



    public synchronized static void init()
	throws Exception
    {
		if (s_instance == null)
			s_instance = new WoodCategoryDataProvider();
    }

    public static WoodCategoryDataProvider getInstance() throws Exception
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
    	categories = WoodDB.getAllCategory();
    }

    public WoodCategory[] getAllCategories()
    {
		return categories;
    }
}