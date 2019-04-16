package com.ebiz.cache;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;
import java.io.*;



public class SqlConfig {
	String resource = "SqlMapConfig.xml";
	
	private static SqlConfig s_instance = null;
	
	private SqlMapClient sqlMap;
	
    protected SqlConfig()
	throws Exception
    {
		//logger.debug("SqlConfig");
		load();
		//logger.debug("SqlConfig");
    }

    public void clear()
    {
    	
    }

    public synchronized static void init()
	throws Exception
    {
		if (s_instance == null)
			s_instance = new SqlConfig();
    }

    public static SqlConfig getInstance() throws Exception
    {
		if( s_instance == null )
			init();

		return s_instance;
    }



    public void load() throws Exception
    {
		try{
			loadData();
		}
		catch (Exception e){
			//logger.error("ConfigDataProvider::load",e);
		}
    }

    public void loadData() throws Exception
    {
		Reader reader = Resources.getResourceAsReader (resource);
		sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
    }

    public SqlMapClient getSqlMap()
    {
		return sqlMap;
    }	
}
