package com.ebiz.cache;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ebiz.data.Shipper;
import com.ebiz.db.ShipDB;

public class ShipperDataProvider extends DataProvider
{
	static Logger logger = Logger.getLogger(ShipperDataProvider.class.getName());
	
    private static ShipperDataProvider s_instance = null;
    
    // instance variables
    private HashMap<String,Shipper> map = null;
    private Shipper[] shippers = null;

    protected ShipperDataProvider()
	throws Exception
    {
		logger.debug("ShipperDataProvider");
		load();
		logger.debug("ShipperDataProvider");
    }

    public void clear()
    {
    	map = new HashMap<String,Shipper>();
    	shippers = null;
    }



    public synchronized static void init()
	throws Exception
    {
		if (s_instance == null)
			s_instance = new ShipperDataProvider();
    }

    public static ShipperDataProvider getInstance() throws Exception
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
			logger.error("ShipperDataProvider::load",e);
		}
    }

    public void loadData() throws Exception
    {
    	shippers = ShipDB.getAllShippers();
    	for( int i=0; i<shippers.length; i++ ){
    		map.put(String.valueOf(shippers[i].getId()), shippers[i]);
    	}
    }

    public Shipper getShipper(String id)
    {
		return map.get(id);
    }
    
    public Shipper[] getShippers()
    {
		return shippers;    	
    }
}