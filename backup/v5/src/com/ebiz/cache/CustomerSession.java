package com.ebiz.cache;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ebiz.data.Constants;
import com.ebiz.data.OrderWoodProduct;
import com.ebiz.data.User;

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
	
	public static void validateAdminPermission(HttpServletResponse response, HttpSession session)
		throws IOException
	{
		try{
			User user = (User) session.getAttribute(Constants.s_LOGGIN);
			//User doesn't have admin permission privileges.  Route back to login page!
			if( user.getPermission() == null ){
				//session.setAttribute(Constants.s_ERROR,"You do not have permission to access this page.  Please login.");
				response.sendRedirect(Constants.s_PAGE_ROOT_ADMIN+"Logon.jsp");
			}
		}
		catch(Exception e){
			session.setAttribute(Constants.s_ERROR,e.getMessage());
			response.sendRedirect(Constants.s_PAGE_ROOT_ADMIN+"Logon.jsp");
		}
	}
	
	public static OrderWoodProduct[] getOrders(HashMap<String, OrderWoodProduct> map)
	{
		OrderWoodProduct[] rets = new OrderWoodProduct[map.size()];
		Set<String> sets = map.keySet();
		int i = 0;
		for( Iterator<String> iter=sets.iterator(); iter.hasNext(); )
		{
			rets[i++] = map.get(iter.next());
		}
		
		return rets;
		
	}
}
