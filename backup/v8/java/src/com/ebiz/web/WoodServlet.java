package com.ebiz.web;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ebiz.cache.TransactionDataProvider;
import com.ebiz.data.Constants;
import com.ebiz.data.OrderWoodProduct;
import com.ebiz.data.Transaction;
import com.ebiz.db.OrderDB;
import com.ebiz.framework.data.PaymentException;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.payment.IPayment;
import com.ebiz.paypal.PayPalPayment;
import com.ebiz.utils.Util;

public class WoodServlet extends HttpServlet {
	static Logger logger = Logger.getLogger(WoodServlet.class.getName());
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost ( HttpServletRequest request, HttpServletResponse response )
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		logger.debug("WoodServlet::doPost:START");
		try{
			OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
			orderProducts[0].getOrder().setClientId(request.getRemoteAddr());
			orderProducts[0].getOrder().setStatus(String.valueOf(Constants.s_ORDER_PROCESSING_CODE));
			processOrder(orderProducts);
			session.setAttribute(Constants.s_CUSTOMER_ORDER_CART, orderProducts);
			response.sendRedirect(Constants.s_PAGE_ROOT_WOOD + "orderConfirmation.jsp");
		}
		catch(Exception e){
			e.printStackTrace();
			session.setAttribute(Constants.s_ERROR,e.getMessage());
			response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"error.jsp");
		}
		finally{
			logger.debug("WoodServlet::doPost:END");
		}
	}
	
	private void processOrder(OrderWoodProduct[] orderProducts)
		throws ServiceException
	{
		//STEP 1: Insert this order into our DB
		OrderDB db = new OrderDB();
		int orderId = db.createOrder(orderProducts);
		orderProducts[0].getOrder().setOrderId(orderId);
		orderProducts[0].getOrder().setConfirmationNo(orderId+"*"+Util.getRandomLetters(5, true));
		orderProducts[0].getOrder().setCreateDate(new java.util.Date());
		
		Transaction transaction;
		TransactionDataProvider transactionJobs = TransactionDataProvider.getInstance();
		
		//STEP 2: Process payment with vendor
		try{
			
//*******TEST CODE FOR NOW... NEED TO COMMENT OUT*****************************
			orderProducts[0].getOrder().getPayment().setAmount(0.01);
//*******TEST CODE FOR NOW... NEED TO COMMENT OUT*****************************
			
			IPayment payment = new PayPalPayment();
			System.out.println("WoodServlet::doPost:payment:1");
			String paymentConfirmId = payment.processPayment(orderProducts[0].getOrder());
			System.out.println("WoodServlet::doPost:payment:2");
			orderProducts[0].getOrder().getPayment().setVendorConfirmationNo(paymentConfirmId);
			orderProducts[0].getOrder().setStatus(String.valueOf(Constants.s_ORDER_SUCCESS_CODE));
		}
		catch(PaymentException pe){
			System.out.println("WoodServlet::doPost:paymentError:"+pe.getMessage());
			//Failed payment needs to update our DB with status for this order.  Reject the order
			paymentExceptionHandler(orderProducts, transactionJobs);
			System.out.println("WoodServlet::doPost:payment:3");
			throw new ServiceException(pe);
		}		
		catch(ServiceException se){
			System.out.println("WoodServlet::doPost:paymentError:"+se.getMessage());
			//Failed payment needs to update our DB with status for this order.  Reject the order
			paymentExceptionHandler(orderProducts, transactionJobs);
			System.out.println("WoodServlet::doPost:payment:3");
			throw se;
		}
		
		try{
			//STEP 3: Update our DB with latest payment status and ready for SHIPPING!
			transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD, Constants.s_ORDER_PAYMENT_CODE, 
											new Date(), orderProducts);
			transactionJobs.addTransaction(transaction);

			//STEP 4: Update our DB with latest order status
			transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD, Constants.s_ORDER_UPDATE_ORDER_CODE, 
											new Date(), orderProducts);
			transactionJobs.addTransaction(transaction);

			//STEP 4: ORDER completed.  Send mail to customer
			transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD, Constants.s_ORDER_NOTIFY_CODE, 
										new Date(), orderProducts);
			transactionJobs.addTransaction(transaction);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	private void paymentExceptionHandler(OrderWoodProduct[] orderProducts, TransactionDataProvider transactionJobs)
	{
		//Failed payment needs to update our DB with status for this order.  Reject the order
		orderProducts[0].getOrder().setStatus(String.valueOf(Constants.s_ORDER_ERROR_CODE));
		Transaction transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD, Constants.s_ORDER_UPDATE_ORDER_CODE, 
										new Date(), orderProducts);
		transactionJobs.addTransaction(transaction);			

		transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD, Constants.s_ORDER_PAYMENT_CODE, 
				new Date(), orderProducts);
		transactionJobs.addTransaction(transaction);
	}
} 