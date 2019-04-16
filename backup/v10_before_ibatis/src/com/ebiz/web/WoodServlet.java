package com.ebiz.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import org.apache.log4j.Logger;
import com.ebiz.cache.LoggerDataProvider;

import com.ebiz.data.Constants;
import com.ebiz.data.OrderWoodProduct;
import com.ebiz.process.ProcessOrder;

public class WoodServlet extends HttpServlet {
	// static Logger logger = Logger.getLogger(WoodServlet.class.getName());
	LoggerDataProvider logger = LoggerDataProvider.getInstance();

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		logger.debug("WoodServlet::doPost:START");
		HttpSession session = request.getSession();
		try {
			logger.debug("WoodServlet::doPost:1");
			response.sendRedirect(Constants.s_PAGE_ROOT_WOOD + "orderConfirmation.jsp");
		} catch (Exception e) {
			logger.debug("WoodServlet::doPost:ERROR:" + e.toString());
			e.printStackTrace();
			session.setAttribute(Constants.s_ERROR, e.getMessage());
			response.sendRedirect(Constants.s_PAGE_ROOT_WOOD + "error.jsp");
		} finally {
			logger.debug("WoodServlet::doPost:END");
		}
	}

	public void doPost2(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		logger.debug("WoodServlet::doPost:START");
		HttpSession session = request.getSession();
		logger.debug("WoodServlet::doPost:1");
		try {
			OrderWoodProduct[] orderProducts = (OrderWoodProduct[]) session
					.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
			logger.debug("WoodServlet::doPost:2");
			orderProducts[0].getOrder().setClientId(request.getRemoteAddr());
			orderProducts[0].getOrder().setStatus(
					String.valueOf(Constants.s_ORDER_PROCESSING_CODE));
			logger.debug("WoodServlet::doPost:3");
			ProcessOrder p = new ProcessOrder();
			p.processOrder(orderProducts);
			logger.debug("WoodServlet::doPost:4");
			session
					.setAttribute(Constants.s_CUSTOMER_ORDER_CART,
							orderProducts);
			response.sendRedirect(Constants.s_PAGE_ROOT_WOOD
					+ "orderConfirmation.jsp");
		} catch (Exception e) {
			logger.debug("WoodServlet::doPost:ERROR:" + e.toString());
			e.printStackTrace();
			session.setAttribute(Constants.s_ERROR, e.getMessage());
			response.sendRedirect(Constants.s_PAGE_ROOT_WOOD + "error.jsp");
		} finally {
			logger.debug("WoodServlet::doPost:END");
		}
	}
	/*
	 * private void processOrder(OrderWoodProduct[] orderProducts) throws
	 * ServiceException { logger.debug("WoodServlet::processOrder:1"); //STEP 1:
	 * Insert this order into our DB OrderDB db = new OrderDB(); int orderId =
	 * db.createOrder(orderProducts);
	 * logger.debug("WoodServlet::processOrder:2");
	 * orderProducts[0].getOrder().setOrderId(orderId);
	 * orderProducts[0].getOrder
	 * ().setConfirmationNo(orderId+"*"+Util.getRandomLetters(5, true));
	 * orderProducts[0].getOrder().setCreateDate(new java.util.Date());
	 * logger.debug("WoodServlet::processOrder:3"); Transaction transaction;
	 * TransactionDataProvider transactionJobs =
	 * TransactionDataProvider.getInstance();
	 * 
	 * //STEP 2: Process payment with vendor try{
	 * logger.debug("WoodServlet::processOrder:4"); //TEST CODE FOR NOW... NEED
	 * TO COMMENT OUT orderProducts[0].getOrder().getPayment().setAmount(0.01);
	 * //TEST CODE FOR NOW... NEED TO COMMENT OUT
	 * 
	 * IPayment payment = new PayPalPayment(); String paymentConfirmId =
	 * payment.processPayment(orderProducts[0].getOrder());
	 * orderProducts[0].getOrder
	 * ().getPayment().setVendorConfirmationNo(paymentConfirmId);
	 * orderProducts[0
	 * ].getOrder().setStatus(String.valueOf(Constants.s_ORDER_SUCCESS_CODE));
	 * logger.debug("WoodServlet::processOrder:5"); } catch(PaymentException
	 * pe){ logger.debug("WoodServlet::doPost:paymentError:"+pe.toString());
	 * //Failed payment needs to update our DB with status for this order.
	 * Reject the order paymentExceptionHandler(orderProducts, transactionJobs);
	 * throw new ServiceException(pe); } catch(ServiceException se){
	 * logger.debug("WoodServlet::doPost:paymentError:"+se.toString()); //Failed
	 * payment needs to update our DB with status for this order. Reject the
	 * order paymentExceptionHandler(orderProducts, transactionJobs); throw se;
	 * } logger.debug("WoodServlet::processOrder:6"); try{ //STEP 3: Update our
	 * DB with latest payment status and ready for SHIPPING! transaction = new
	 * Transaction(Constants.s_PRODUCT_TYPE_WOOD,
	 * Constants.s_ORDER_PAYMENT_CODE, new Date(), orderProducts);
	 * transactionJobs.addTransaction(transaction);
	 * logger.debug("WoodServlet::processOrder:7"); //STEP 4: Update our DB with
	 * latest order status transaction = new
	 * Transaction(Constants.s_PRODUCT_TYPE_WOOD,
	 * Constants.s_ORDER_UPDATE_ORDER_CODE, new Date(), orderProducts);
	 * transactionJobs.addTransaction(transaction);
	 * logger.debug("WoodServlet::processOrder:8"); //STEP 4: ORDER completed.
	 * Send mail to customer transaction = new
	 * Transaction(Constants.s_PRODUCT_TYPE_WOOD, Constants.s_ORDER_NOTIFY_CODE,
	 * new Date(), orderProducts); transactionJobs.addTransaction(transaction);
	 * logger.debug("WoodServlet::processOrder:9"); } catch(Exception e){
	 * e.printStackTrace(); }
	 * 
	 * }
	 * 
	 * private void paymentExceptionHandler(OrderWoodProduct[] orderProducts,
	 * TransactionDataProvider transactionJobs) { //Failed payment needs to
	 * update our DB with status for this order. Reject the order
	 * orderProducts[0
	 * ].getOrder().setStatus(String.valueOf(Constants.s_ORDER_ERROR_CODE));
	 * Transaction transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD,
	 * Constants.s_ORDER_UPDATE_ORDER_CODE, new Date(), orderProducts);
	 * transactionJobs.addTransaction(transaction);
	 * 
	 * transaction = new Transaction(Constants.s_PRODUCT_TYPE_WOOD,
	 * Constants.s_ORDER_PAYMENT_CODE, new Date(), orderProducts);
	 * transactionJobs.addTransaction(transaction); }
	 */
} 