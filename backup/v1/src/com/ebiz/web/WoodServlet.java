package com.ebiz.web;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ebiz.data.Constants;
import com.ebiz.data.OrderWoodProduct;
import com.ebiz.data.EmailConfirmation;
import com.ebiz.db.OrderDB;
import com.ebiz.framework.data.PaymentException;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.payment.IPayment;
import com.ebiz.paypal.PayPalPayment;
import com.ebiz.utils.Util;
import com.ebiz.utils.SendMail;

public class WoodServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost ( HttpServletRequest request, HttpServletResponse response )
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		System.out.println("WoodServlet::doPost:START");
		try{
			OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
			orderProducts[0].getOrder().setClientId(request.getRemoteAddr());
			orderProducts[0].getOrder().setStatus(Constants.s_ORDER_PROCESSING_CODE);
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
			System.out.println("WoodServlet::doPost:END");
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

		//STEP 2: Process payment with vendor
		String paymentConfirmId = null;
		try{
			
//*******TEST CODE FOR NOW... NEED TO COMMENT OUT*****************************
			orderProducts[0].getOrder().getPayment().setAmount(0.01);
//*******TEST CODE FOR NOW... NEED TO COMMENT OUT*****************************
			
			IPayment payment = new PayPalPayment();
			paymentConfirmId = payment.processPayment(orderProducts[0].getOrder());
			orderProducts[0].getOrder().setStatus(Constants.s_ORDER_SUCCESS_CODE);
		}
		catch(PaymentException pe){
			//Failed payment needs to update our DB with status for this order.  Reject the order
			orderProducts[0].getOrder().setStatus(Constants.s_ORDER_ERROR_CODE);
			db.updateOrder(orderProducts[0].getOrder());
			throw new ServiceException(pe);
		}

		//STEP 3: Update our DB with latest payment status and ready for SHIPPING!
		try{
			db.updatePayment(orderProducts[0].getOrder().getPayment().getPaymentId(), 
					orderProducts[0].getOrder().getPayment().getVendorResponse(), paymentConfirmId);
			db.updateOrder(orderProducts[0].getOrder());
		}
		catch(ServiceException e){
			//put in background thread to process this later...
			e.printStackTrace();
		}
		
		//STEP 4: ORDER completed.  Send mail to customer
		sendMail(orderProducts);
	}
	
	private void sendMail(OrderWoodProduct[] orderProducts) throws ServiceException{
		try{
			//NEED TO FORMAT MESSAGE FROM PURCHASED PRODUCT
			SendMail mail = new SendMail(
					orderProducts[0].getOrder().getCustomer().getEmail(),
					Constants.s_ORDER_WOOD_EMAIL_SUBJECT,
					EmailConfirmation.getWoodEmailConfirmation(orderProducts));
			mail.send();
		}
		catch(MessagingException me){
			//If EMAIL fails, put in background thread to process later...
			me.printStackTrace();
		}
	}
} 