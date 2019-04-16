package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ebiz.cache.EcryptoDataProvider;
import com.ebiz.data.Constants;
import com.ebiz.data.Tracker;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.framework.data.ServiceSecurityException;

public class UtilDB {
	static final String s_SQL_INSERT_TRACKER = 
		"	INSERT INTO Tracker ( category_id, product_id, " +
		"   	product_type, client_id, page, create_date ) " +
		"	VALUES (?,?,?,?,?,sysdate() ) "; 
	
	static final String s_SQL_SELECT_CONFIG =
		" SELECT cKey, cValue FROM Config ORDER BY cKey ";
	
	static Logger logger = Logger.getLogger(UtilDB.class.getName());	
	
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
			logger.debug("UtilDB::insertTracker:START");
			
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
			logger.debug("UtilDB::insertTracker:END");
		}
	}	
	
	/**
	 * getAllConfig - All data in Configuration table
	 * @return HashMap - List of configuration by KEY
	 * @throws ServiceException
	 */
	public static HashMap<String, String> getAllConfig()
			throws ServiceSecurityException, ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			logger.debug("UtilDB::getAllConfig:START");
			
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_SELECT_CONFIG);

			rs = pstmt.executeQuery();

			String key;
			String value;
			HashMap<String, String> map = new HashMap<String, String>();
			// Walk thru resultset
			while (rs.next()) {
				key = rs.getString(1);
				value = rs.getString(2);
				if( Constants.s_PAYPAL_USER_NAME.equals(key) || 
						Constants.s_PAYPAL_PWD.equals(key) || 
						Constants.s_PAYPAL_SIGNATURE.equals(key) )
				{
					value = EcryptoDataProvider.getInstance()
						.getEcrypto().decrypt(value);
				}
				//logger.debug("UtilDB:print again key["+key+"] value["+value+"]");
				map.put(key, value);
			}

			return map;
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch(ServiceSecurityException sse){
			throw sse;
		} catch (Exception e){
			throw new ServiceException(e);
		} finally {
			try {
				rs.close();
			} catch (Exception ignore) {
			}
			try {
				pstmt.close();
			} catch (Exception ignore) {
			}
			try {
				conn.close();
			} catch (Exception ignore) {
			}
			logger.debug("UtilDB::getAllConfig:END");
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
