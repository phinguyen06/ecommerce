package com.ebiz.db;

import java.sql.SQLException;
import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.commons.pool.ObjectPool;
import org.apache.commons.pool.impl.GenericObjectPool;
import org.apache.commons.dbcp.ConnectionFactory;
import org.apache.commons.dbcp.PoolingDataSource;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.log4j.Logger;

import com.ebiz.framework.data.ServiceException;

/**
 * DBConnection is a database wrapper class to create database connection.
 * This class uses apache connection pool library.  If running in Tomcat
 * environment, data source will need to setup in conf/server.xml.  If running
 * locally as standalone application, it will create a connection pool manually
 * from dbcp api
 *
 */
public class DBConnection {
	final String jdbcDriver = "com.mysql.jdbc.Driver";

	final String jdbcUrl = "jdbc:mysql://ebizdeal.db.4247188.hostedresource.com:3306/ebizdeal";
	final String dbUser = "ebizdeal";
	final String dbPassword = "Hona1%%";
/*
	final String jdbcUrl = "jdbc:mysql://localhost:3306/ebizdeal?autoReconnect=true";
	final String dbUser = "phin";
	final String dbPassword = "phin";
*/
	final String dataSourceContext = "java:/comp/env/jdbc/ebizdeal";

	//Connection conn = null;
	DataSource dataSource = null;

	private static DBConnection instance = null;
	
	static Logger logger = Logger.getLogger(DBConnection.class.getName());

	/**
	 * getInstance - get instance of this DB class from the singleton
	 * @return DBConnection
	 * @throws Exception
	 */
	public static DBConnection getInstance() throws Exception
	{
		init();
		return instance;
	}

	/**
	 * init - Create a singleton of this DB class.
	 * @throws Exception
	 */
	public synchronized static void init() throws Exception
	{
		if (null == instance)
			instance = new DBConnection();
	}


	/**
	 * default constructor to construct database connection
	 * @throws ServiceException
	 */
	public DBConnection() throws ServiceException{
		try{
			Context initCtx = new InitialContext();
			dataSource = (DataSource)initCtx.lookup(dataSourceContext);
			logger.debug("dataSource:"+dataSource);
		}
		catch(NamingException ne){
			try
			{
				logger.debug("FAILED: Create connection pool within webapps context.  Create manual.");
				dataSource = setupDataSource();
				//printDataSourceStats();
			}
			catch(Exception e){
				throw new ServiceException(ne);
			}
		}
		catch(Exception e)
		{
			throw new ServiceException(e);
		}
	}

	/**
	 * getConnection - Retrieve a database connection
	 * @return Connection - Database connection
	 */
	public Connection getConnection() throws SQLException{
		// Allocate and use a connection from the pool
		//return dataSource.getConnection();
		
		try{
			Class.forName(jdbcDriver);
			Connection conn = java.sql.DriverManager.getConnection(jdbcUrl,dbUser,dbPassword);
			return conn;
		}
		catch(Exception ignore){
			ignore.printStackTrace();
		}
		
		return null;
		
	}

	/**
	 * setupDataSource - This method is used for standalone application
	 * where data source environment variables aren't available.
	 * We have to setup data source manually.  If we're running within
	 * Tomcat webapp, it's taken care by Tomcat engine
	 * @return
	 */
    private DataSource setupDataSource() throws ServiceException{
    	try{

    	//Loading jdbc driver
    	Class.forName(jdbcDriver);

        //
        // First, we'll need a ObjectPool that serves as the
        // actual pool of connections.
        //
        // We'll use a GenericObjectPool instance, although
        // any ObjectPool implementation will suffice.
        //
        ObjectPool connectionPool = new GenericObjectPool(null);

        //
        // Next, we'll create a ConnectionFactory that the
        // pool will use to create Connections.
        // We'll use the DriverManagerConnectionFactory,
        // using the connect string passed in the command line
        // arguments.
        //
        ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(jdbcUrl,dbUser,dbPassword);

        //
        // Now we'll create the PoolableConnectionFactory, which wraps
        // the "real" Connections created by the ConnectionFactory with
        // the classes that implement the pooling functionality.
        //
        PoolableConnectionFactory poolableConnectionFactory = new PoolableConnectionFactory(connectionFactory,connectionPool,null,null,false,false);
        poolableConnectionFactory.setDefaultAutoCommit(false);

        //
        // Finally, we create the PoolingDriver itself,
        // passing in the object pool we created.
        //
        PoolingDataSource dataSource = new PoolingDataSource(connectionPool);

        return dataSource;

    	/*
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName(driver);
        ds.setUrl(url);
        ds.setUsername(user);
        ds.setPassword(password);
        return ds;
        */
    	}
    	catch(Exception e)
    	{
    		throw new ServiceException(e);
    	}
    }

}
