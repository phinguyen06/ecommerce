package com.ebiz.job;

import com.ebiz.data.Transaction;
import com.ebiz.framework.data.ServiceException;

public interface ITransactionManager {
	public void execute(Transaction transaction) throws ServiceException;
}
