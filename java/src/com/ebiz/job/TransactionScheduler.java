package com.ebiz.job;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ebiz.cache.ConfigDataProvider;
import com.ebiz.cache.TransactionDataProvider;
import com.ebiz.data.Constants;
import com.ebiz.data.Transaction;

public class TransactionScheduler extends Thread{
	static Logger logger = Logger.getLogger(TransactionScheduler.class.getName());
	
	public boolean isContinue = true;
	
	public TransactionScheduler(){
		
	}
	
	/**
	 * run - overwrite the default thread run method with our implementation
	 */
	public void run()
	{
		logger.debug("TransactionScheduler::run:START");
		try
		{
			ITransactionManager transactionManager = null;
			Transaction transaction;
			TransactionDataProvider TransactionDP = TransactionDataProvider.getInstance();
			ArrayList<Transaction> list;
			while(isContinue)
			{ 
				list = TransactionDP.getTransactions();
				logger.debug("TransactionScheduler::run:scheduler running:size:"+list.size());
				if( list != null )
				{
					//logger.debug("TransactionScheduler::run:list is not empty: " + list.size());
					while( list.size() > 0 ){
						try{
							transaction = list.get(0);
							//logger.debug("TransactionScheduler::run:scheduler running:size:inloop:"+list.size());
							if( Constants.s_PRODUCT_TYPE_WOOD.equals(transaction.getType()) )
								transactionManager = new WoodTransactionManager();
							else
								throw new Exception("Not support transaction type - " + transaction.getType());
							
							//Run transaction now
							transactionManager.execute(transaction);
							
							//Successfully executed this transaction, remove from our queue
							list.remove(0);
						}
						catch(Exception e){
							logger.error(e.toString());
						}
					}
				}
				sleep(Integer.parseInt(ConfigDataProvider.getInstance().getValue(Constants.s_CONFIG_SCHEDULER_TRANSACTION_SLEEP_TIME)));
			}
			
		}
		catch(Exception e)
		{
			logger.error(e.toString());
		}
		finally{
			logger.debug("TransactionScheduler::run:END");
		}
	}
}
