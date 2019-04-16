package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.ebiz.data.Tracker;
import com.ebiz.framework.data.ServiceException;

public class UtilDB {
	static final String s_SQL_INSERT_TRACKER = 
		"	INSERT INTO Tracker ( category_id, product_id, " +
		"   	product_type, client_id, page, create_date ) " +
		"	VALUES (?,?,?,?,?,sysdate() ) "; 
	


	
	/**
	 * insertTracker - Insert tracker
	 * @param tracker - New tracker
	 * @throws ServiceException
	 */
	public static void insertTracker(Tracker tracker)
			throws ServiceException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			System.out.println("UtilDB::insertTracker:START");
			
			conn = (DBConnection.getInstance()).getConnection();
			pstmt = conn.prepareStatement(s_SQL_INSERT_TRACKER);	
			
			pstmt.setInt(1, tracker.getCategoryId());
			pstmt.setInt(2, tracker.getProductId());
			pstmt.setString(3, tracker.getProductType());
			pstmt.setString(4, tracker.getClientId());
			pstmt.setString(5, tracker.getPage());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to insert tracker.");
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
			try {
				pstmt.close();
			} catch (Exception ignore) {
			}
			try {
				conn.close();
			} catch (Exception ignore) {
			}
		}
	}	
	

	
	public static void main(String[] args) throws Exception
	{
		Tracker t = new Tracker();
		t.setCategoryId(1);
		t.setClientId("10.10.10.255");
		t.setProductId(35);
		t.setProductType("WOOD");
		
		UtilDB.insertTracker(t);		
		
		
	}
}
