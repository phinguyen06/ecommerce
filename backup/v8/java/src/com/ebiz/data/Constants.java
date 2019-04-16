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
	//public final static String s_PAGE_ROOT_WOOD = "/ebiz/wood/";
	//public final static String s_PAGE_ROOT_ADMIN = "/ebiz/admin/";
	//public final static String s_PAGE_ROOT = "/ebiz/";
	public final static String s_PAGE_ROOT_WOOD = "/";
	public final static String s_PAGE_ROOT_ADMIN = "/";
	public final static String s_PAGE_ROOT = "/";
	public final static String s_ORDER_WOOD_EMAIL_SUBJECT = "eBiz Order Confirmation";

	public final static String s_FORGOT_EMAIL_SUBJECT = "eBiz Password Resend";

	//EMAIL Configuration
	public final static String s_EMAIL_FROM = "global_ebiz@gmail.com";
	public final static String s_EMAIL_SMTP_AUTH_USER = "phi2006@gmail.com";
	public final static String s_EMAIL_SMTP_AUTH_PWD = "bellevue";
	public final static String s_EMAIL_SERVER = "gmail-smtp.l.google.com";
	public final static String s_EMAIL_HOST = "mail.smtp.host";

	//PAYPAL Configuration
	//PROD
	//public final static String s_PAYPAL_USER_NAME = "phi2006_api1.gmail.com";
	//public final static String s_PAYPAL_PWD = "F7VHBWYCXUV2KYLL";
	//public final static String s_PAYPAL_SIGNATURE = "AooWeMwEUprSb-58ApUiwGtQwDFIAP2Fcdm3MR7xCJR-uVKrSCED7HxD";
	//SANDBOX TEST
	public final static String s_PAYPAL_USER_NAME = "ppu";
	public final static String s_PAYPAL_PWD = "ppp";
	public final static String s_PAYPAL_SIGNATURE = "pps";
	public static final String s_PAYPAL_SERVER = "sandbox";
	//public final static String s_PAYPAL_USER_NAME = "brando_1236904149_biz_api1.yahoo.com";
	//public final static String s_PAYPAL_PWD = "1236904156";
	//public final static String s_PAYPAL_SIGNATURE = "Az-d2M7YeHW.K9EvxlnkjtZJbVRKAlVAvKD08puJ8JstAkWxo5TwvXZz";

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
	//PayPal related
	public final static String s_PAYPAL_SERVER_URL = "https://api-3t.sandbox.paypal.com/nvp";

	//Config related key
	public final static String s_CONFIG_SCHEDULER_TRACKER_SLEEP_TIME = "scheduler.tracker.sleep.ms";
	public final static String s_CONFIG_SCHEDULER_TRANSACTION_SLEEP_TIME = "scheduler.transaction.sleep.ms";

}
