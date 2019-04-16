package com.ebiz.cache;

import javax.servlet.http.HttpSession;

import com.ebiz.data.Constants;

public class CustomerSession {
	public static void clearSession(HttpSession session){
		try{
			session.removeAttribute(Constants.s_CUSTOMER_CART);
			session.removeAttribute(Constants.s_CUSTOMER);
			session.removeAttribute(Constants.s_CUSTOMER_ORDER_CART);
			session.removeAttribute(Constants.s_ERROR);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
