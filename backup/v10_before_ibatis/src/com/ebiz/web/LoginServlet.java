package com.ebiz.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ebiz.framework.data.ServiceException;
import com.ebiz.framework.data.ServiceSecurityException;
import com.ebiz.data.Constants;
import com.ebiz.data.User;
import com.ebiz.db.UserDB;


public class LoginServlet extends HttpServlet {
	static Logger logger = Logger.getLogger(LoginServlet.class.getName());
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost ( HttpServletRequest request, HttpServletResponse response )
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		logger.debug("LoginServlet::doPost:START");
		boolean isOwner = false;
		try{
			String email = request.getParameter("txtEmail");
			String password = request.getParameter("txtPassword");
			request.getParameter("txtProductType");
			String nextPage = request.getParameter("hdnNextPage");
			isOwner = request.getParameter("hdnO") == null ? false : ("Y".equals(request.getParameter("hdnO")));
			User user = validateLogin(email,password, isOwner);
			session.setAttribute(Constants.s_LOGGIN,user);
			response.sendRedirect(nextPage);
		}
		catch(ServiceSecurityException sse){
			logger.error(sse.toString());
			session.setAttribute(Constants.s_ERROR,sse.getMessage());
			if( isOwner )
				response.sendRedirect(Constants.s_PAGE_ROOT_ADMIN+"Logon.jsp");
			else
				response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"Logon.jsp");
		}
		catch(ServiceException sse){
			logger.error(sse.toString());
			session.setAttribute(Constants.s_ERROR,sse.getMessage());
			if( isOwner )
				response.sendRedirect(Constants.s_PAGE_ROOT_ADMIN+"Logon.jsp");
			else
				response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"Logon.jsp");
		}
		finally{
			logger.debug("LoginServlet::doPost:END");
		}
	}
	
	private User validateLogin(String email, String password, boolean isOwner) throws ServiceException, ServiceSecurityException
	{
		User rets;
		if( isOwner )
			rets = UserDB.validateAdminUser(email, password);
		else
			rets = UserDB.validateUser(email, password, true);
		//This user doesn't have permission to access administration pages
		if( isOwner && rets.getPermission() == null )
			throw new ServiceSecurityException("You does not have permission to access this page!");
		return rets;
	}
	

} 