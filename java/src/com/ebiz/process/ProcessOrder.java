package com.ebiz.process;

import java.util.Date;

import com.ebiz.cache.LoggerDataProvider;
import com.ebiz.cache.TransactionDataProvider;
import com.ebiz.data.Constants;
import com.ebiz.data.OrderWoodProduct;
import com.ebiz.data.Transaction;
import com.ebiz.db.OrderDB;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.utils.Util;

public class ProcessOrder {
	LoggerDataProvider logger = LoggerDataProvider.getInstance();

	public void processOrder(OrderWoodProduct[] orderProducts)
			throws ServiceException {
		logger.debug("ProcessOrder::processOrder:1");
		// STEP 1: Insert this order into our DB
		OrderDB db = new OrderDB();
		int orderId = db.createOrder(orderProducts);
		logger.debug("ProcessOrder::processOrder:2");
		orderProducts[0].getOrder().setOrderId(orderId);
		orderProducts[0].getOrder().setConfirmationNo(
				orderId + "*" + Util.getRandomLetters(5, true));
		orderProducts[0].getOrder().setCreateDate(new java.util.Date());
		logger.debug("ProcessOrder::processOrder:3");
		Transaction transaction;
		TransactionDataProvider transactionJobs = TransactionDataProvider
				.getInstance();

		// STEP 2: Process payment with vendor
		
		//COMMENT OUT PAYPAL PAYMENT FOR NOW.  WE ARE USING GOOGLE CHECKOUT BY USING HTML REDIRECT.
		//  WILL NEED TO IMPLEMENT GOOGLE CHECKOUT API LATER.  THEN REUSE THIS SECTION...
		
		orderProducts[0].getOrder().getPayment().setVendorConfirmationNo("10000");
		orderProducts[0].getOrder().setStatus(
				String.valueOf(Constants.s_ORDER_SUCCESS_CODE));
		/*
		try {
			logger.debug("ProcessOrder::processOrder:4");
			// *******TEST CODE FOR NOW... NEED TO COMMENT
			// OUT*****************************
			//orderProducts[0].getOrder().getPayment().setAmount(0.01);
			// *******TEST CODE FOR NOW... NEED TO COMMENT
			// OUT*****************************

			
			IPayment payment = new PayPalPayment();
			String paymentConfirmId = payment.processPayment(orderProducts[0]
					.getOrder());
			orderProducts[0].getOrder().getPayment().setVendorConfirmationNo(
					paymentConfirmId);
			orderProducts[0].getOrder().setStatus(
					String.valueOf(Constants.s_ORDER_SUCCESS_CODE));
			logger.debug("ProcessOrder::processOrder:5");
		} catch (PaymentException pe) {
			logger.debug("ProcessOrder::doPost:paymentError:" + pe.toString());
			// Failed payment needs to update our DB with status for this order.
			// Reject the order
			paymentExceptionHandler(orderProducts, transactionJobs);
			throw new ServiceException(pe);
		} catch (ServiceException se) {
			logger.debug("ProcessOrder::doPost:paymentError:" + se.toString());
			// Failed payment needs to update our DB with status for this order.
			// Reject the order
			paymentExceptionHandler(orderProducts, transactionJobs);
			throw se;
		}
		*/
		logger.debug("ProcessOrder::processOrder:6");
		try {
			// STEP 3: Update our DB with latest payment status and ready for
			// SHIPPING!
			transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD,
					Constants.s_ORDER_PAYMENT_CODE, new Date(), orderProducts);
			transactionJobs.addTransaction(transaction);
			logger.debug("ProcessOrder::processOrder:7");
			// STEP 4: Update our DB with latest order status
			transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD,
					Constants.s_ORDER_UPDATE_ORDER_CODE, new Date(),
					orderProducts);
			transactionJobs.addTransaction(transaction);
			logger.debug("ProcessOrder::processOrder:8");
			// STEP 4: ORDER completed. Send mail to customer
			transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD,
					Constants.s_ORDER_NOTIFY_CODE, new Date(), orderProducts);
			transactionJobs.addTransaction(transaction);
			logger.debug("ProcessOrder::processOrder:9");
			// STEP 5: update our product inventory
			transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD,
					Constants.s_UPDATE_PRODUCT_QUANTITY_CODE, new Date(), orderProducts);
			transactionJobs.addTransaction(transaction);			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/*
	private void paymentExceptionHandler(OrderWoodProduct[] orderProducts,
			TransactionDataProvider transactionJobs) {
		// Failed payment needs to update our DB with status for this order.
		// Reject the order
		orderProducts[0].getOrder().setStatus(
				String.valueOf(Constants.s_ORDER_ERROR_CODE));
		Transaction transaction = new Transaction(
				Constants.s_PRODUCT_TYPE_WOOD,
				Constants.s_ORDER_UPDATE_ORDER_CODE, new Date(), orderProducts);
		transactionJobs.addTransaction(transaction);

		transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD,
				Constants.s_ORDER_PAYMENT_CODE, new Date(), orderProducts);
		transactionJobs.addTransaction(transaction);
	}
	*/
}
