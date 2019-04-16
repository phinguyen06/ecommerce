package com.ebiz.cache;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ebiz.data.Transaction;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.job.TransactionScheduler;

public class TransactionDataProvider extends DataProvider
{
	static Logger logger = Logger.getLogger(TransactionDataProvider.class.getName());
	
    private static TransactionDataProvider s_instance = null;
    
    ArrayList<Transaction> list = null;

    // instance variables

    protected TransactionDataProvider()
	throws ServiceException
    {
		logger.debug("TransactionDataProvider");
		load();
		//Start Transaction timer thread to insert data into DB on the background
		logger.debug("TransactionDataProvider");
    }

    public void clear()
    {
    	list = null;
    }



    public synchronized static void init()
	throws ServiceException
    {
		if (s_instance == null){
			s_instance = new TransactionDataProvider();
			//daemon thread will allow tomcat to shutdown successfully.  Otherwise active thread will block tomcat shutdown session!
			TransactionScheduler transactionThread = new TransactionScheduler();
			transactionThread.setDaemon(true);
			transactionThread.start();
		}
    }

    public static TransactionDataProvider getInstance() throws ServiceException
    {
		if( s_instance == null )
			init();

		return s_instance;
    }



    public void load() throws ServiceException
    {
		try{
			register();
			clear();
			loadData();
		}
		catch (Exception e){
			logger.error("TransactionDataProvider::load",e);
		}
    }

    public void loadData() throws ServiceException
    {
    	list = new ArrayList<Transaction>();
    }
    
    public void addTransaction(Transaction Transaction)
    {
    	list.add(Transaction);
    }

    public ArrayList<Transaction> getTransactions()
    {
		return list;
    }
}