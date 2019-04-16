package com.ebiz.job;

import javax.mail.MessagingException;

import org.apache.log4j.Logger;

import com.ebiz.data.Constants;
import com.ebiz.data.EmailConfirmation;
import com.ebiz.data.Order;
import com.ebiz.data.OrderWoodProduct;
import com.ebiz.data.Payment;
import com.ebiz.data.Transaction;
import com.ebiz.db.OrderDB;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.utils.SendMail;

public class WoodTransactionManager implements ITransactionManager{

	static Logger logger = Logger.getLogger(WoodTransactionManager.class.getName());
	
	public void execute(Transaction transaction) throws ServiceException
	{
		switch( transaction.getCurrentStep() )
		{
			//1. UPDATE PAYMENT TABLE WITH STATUS FROM PAYPAY
			case Constants.s_ORDER_PAYMENT_CODE: 
				updatePayment(((OrderWoodProduct[])transaction.getData())[0].getOrder().getPayment());
				break;
			case Constants.s_ORDER_UPDATE_ORDER_CODE: 
				updateOrder(((OrderWoodProduct[])transaction.getData())[0].getOrder());
				break;
			case Constants.s_ORDER_NOTIFY_CODE: 
				sendMail(((OrderWoodProduct[])transaction.getData()));
				break;
			default: throw new ServiceException("Unsupported transaction type - "+transaction.getCurrentStep());
		}
	}

	private void updatePayment(Payment payment) throws ServiceException
	{
		OrderDB db = new OrderDB();
		db.updatePayment(payment.getPaymentId(), payment.getVendorResponse(), payment.getVendorConfirmationNo());
	}

	private void updateOrder(Order order) throws ServiceException
	{
		OrderDB db = new OrderDB();
		db.updateOrder(order);
	}
		
	private void sendMail(OrderWoodProduct[] orderProducts) throws ServiceException
	{
		logger.debug("WoodTransactionManager::sendMail:START");
		try{
			//NEED TO FORMAT MESSAGE FROM PURCHASED PRODUCT
			SendMail mail = new SendMail(
					orderProducts[0].getOrder().getCustomer().getEmail(),
					Constants.s_ORDER_WOOD_EMAIL_SUBJECT,
					EmailConfirmation.getWoodEmailConfirmation(orderProducts));
			mail.send();
		}
		catch(MessagingException me){
			throw new ServiceException(me);
		}
		catch(Exception e){
			throw new ServiceException(e);
		}
		finally{
			logger.debug("WoodTransactionManager::sendMail:END");
		}
	}
	
}
