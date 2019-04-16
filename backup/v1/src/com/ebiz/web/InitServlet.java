package com.ebiz.web;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.ebiz.cache.StateDataProvider;
import com.ebiz.cache.StatusCodeDataProvider;
import com.ebiz.cache.WoodCategoryDataProvider;
import com.ebiz.cache.WoodProductDataProvider;

public class InitServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		System.out.println("InitServlet::doPost:START");
		try {
			StateDataProvider.init();
			WoodCategoryDataProvider.init();
			WoodProductDataProvider.init();
			StatusCodeDataProvider.init();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("WoodServlet::doPost:END");
		}

		// ServletContext context = getServletContext();
		// dbName = context.getInitParameter("name");
		// dbPassword = context.getInitParameter("password");
	}

}