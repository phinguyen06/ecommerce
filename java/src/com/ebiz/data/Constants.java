package com.ebiz.data;

public class Constants {
	//HTTP LOGIN
	public final static String s_LOGGIN = "LOGIN";
	public final static String s_WEB_USER_PROFILE = "User";

	//HTTP SESSION related constants
	public final static String s_CATEGORY = "CATEGORIES";
	public final static String s_PRODUCT = "PRODUCTS";
	public final static String s_SELECTED_PRODUCT = "SELECTED_PRODUCT";
	public final static String s_CUSTOMER_CART = "CUSTOMER_CART";
	public final static String s_CUSTOMER = "CUSTOMER";
	public final static String s_CUSTOMER_ORDER_CART = "CUSTOMER_ORDER_CART";
	public final static String s_CUSTOMER_REVIEW_CART = "CUSTOMER_REVIEW_CART";
	public final static String s_ERROR = "ERROR";

	//WOOD related constants
	public final static String s_PRODUCT_TYPE_WOOD = "WOOD";

	
   /*********** START LOCALHOST SETTING *************************/
	public final static String s_PAGE_ROOT_WOOD = "/ebiz/gifts/";
	public final static String s_PAGE_ROOT_ADMIN = "/ebiz/admin/";
	public final static String s_PAGE_ROOT = "/ebiz/";
	public static final String s_PAYPAL_SERVER = "sandbox";	
	public final static String s_PAYPAL_SERVER_URL = "https://api-3t.sandbox.paypal.com/nvp";
	public static final String s_GOOGLE_CHECKOUT_CHECKOUTFORM_SERVER_URL = "https://sandbox.google.com/checkout/api/checkout/v2/checkoutForm/Merchant/";
	public static final String s_GOOGLE_CHECKOUT_REQUESTFORM_SERVER_URL = "https://sandbox.google.com/checkout/api/checkout/v2/requestForm/Merchant/";
	public static final String s_GOOGLE_CHECKOUT_MERCHANT_ID = "911197016488855";
	public static final String s_GOOGLE_CHECKOUT_MERCHANT_KEY = "Jd54i_0LDKBdZeg5L3X3kA";
	public static final int    s_GOOGLE_CHECKOUT_SERVER_PORT = 80;
	/*********** END LOCALHOST SETTING *************************/
	
	/*********** START PRODUCTION SETTING *************************/
	/*
	public final static String s_PAGE_ROOT_WOOD = "/gifts/";
	public final static String s_PAGE_ROOT_ADMIN = "/admin/";
	public final static String s_PAGE_ROOT = "/";
	public static final String s_PAYPAL_SERVER = "live";
	public final static String s_PAYPAL_SERVER_URL = "https://api-3t.paypal.com/nvp";
	public static final String s_GOOGLE_CHECKOUT_CHECKOUTFORM_SERVER_URL = "https://checkout.google.com/api/checkout/v2/checkoutForm/Merchant/";
	public static final String s_GOOGLE_CHECKOUT_REQUESTFORM_SERVER_URL = "https://checkout.google.com/api/checkout/v2/requestForm/Merchant/";
	public static final String s_GOOGLE_CHECKOUT_MERCHANT_ID = "544110296651922";
	public static final String s_GOOGLE_CHECKOUT_MERCHANT_KEY = "5gDxZly72hlF1ST1pMTaQA";
	*/
	/*********** END PRODUCTION SETTING *************************/
	
	//PAYPAL Configuration
	public final static String s_PAYPAL_USER_NAME = "ppu";
	public final static String s_PAYPAL_PWD = "ppp";
	public final static String s_PAYPAL_SIGNATURE = "pps";
	
	
	public final static String s_ORDER_WOOD_EMAIL_SUBJECT = "eBiz Order Confirmation";
	public final static String s_FORGOT_EMAIL_SUBJECT = "eBiz Password Resend"; 

	//EMAIL Configuration
	public final static String s_EMAIL_FROM = "xxx@gmail.com";
	public final static String s_EMAIL_SMTP_AUTH_USER = "xxx@gmail.com";
	public final static String s_EMAIL_SMTP_AUTH_PWD = "xxx";
	public final static String s_EMAIL_SERVER = "gmail-smtp.l.google.com";
	public final static String s_EMAIL_HOST = "mail.smtp.host";
	
	//Use this email to test on prod
	public final static String s_TEST_CUSTOMER = "xxx@yahoo.com";

	//ERROR related
	public final static String s_ERROR_MSG_ORDER_PROBLEM = "Sorry for the Inconvenience.  We are unable to process order.  Please contact our customer service for help.";
	public final static char s_ORDER_ERROR_CODE = 'E';
	public final static char s_ORDER_SUCCESS_CODE = 'C';
	public final static char s_ORDER_PROCESSING_CODE = 'I';
	public final static char s_ORDER_SHIPPED_CODE = 'S';
	public final static char s_ORDER_PAYMENT_CODE = 'P';
	public final static char s_ORDER_NOTIFY_CODE = 'N';
	public final static char s_ORDER_SHIP_NOTIFY_CODE = 'M';
	public final static char s_ORDER_UPDATE_ORDER_CODE = 'O';
	public final static char s_UPDATE_PRODUCT_QUANTITY_CODE = 'Q';
	public final static String s_PRODUCT_BACK_ORDER_MSG = "(This product is currently in backorder.  Please allow a minimum of 8 weeks for our manufacture to handmade the product)";
	

	//Config related key
	public final static String s_CONFIG_SCHEDULER_TRACKER_SLEEP_TIME = "scheduler.tracker.sleep.ms";
	public final static String s_CONFIG_SCHEDULER_TRANSACTION_SLEEP_TIME = "scheduler.transaction.sleep.ms";
	 

}
