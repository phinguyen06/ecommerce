package com.ebiz.cache;

import com.ebiz.data.WoodCategory;
import com.ebiz.data.WoodProduct;
import com.ebiz.db.WoodDB;

public class WoodProductDataProvider extends DataProvider
{
    private static WoodProductDataProvider s_instance = null;

    // instance variables
    private WoodProduct[] products  = null;

    protected WoodProductDataProvider()
	throws Exception
    {
		//Trace.begin("WoodCategoryDataProvider");
		load();
		//Trace.end("WoodCategoryDataProvider");
    }

    public void clear()
    {
    	products = null;
    }



    public synchronized static void init()
	throws Exception
    {
		if (s_instance == null)
			s_instance = new WoodProductDataProvider();
    }

    public static WoodProductDataProvider getInstance() throws Exception
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
    	WoodCategory[] categories = WoodCategoryDataProvider.getInstance().getAllCategories();
    	int[] cats = new int[categories.length];
    	for(int i=0; i<cats.length; i++){
    		cats[i] = categories[i].getId();
    	}
    	products = WoodDB.getHotWoodProduct(cats);
    }

    public WoodProduct[] getAllProducts()
    {
		return products;
    }
}