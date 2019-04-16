package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ebiz.cache.EcryptoDataProvider;
import com.ebiz.cache.SqlConfig;
import com.ebiz.data.Config;
import com.ebiz.data.Constants;
import com.ebiz.data.Tracker;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.framework.data.ServiceSecurityException;
import com.ibatis.sqlmap.client.SqlMapClient;

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
		SqlMapClient sqlMap = null;
		try {
			logger.debug("WoodDB::insertTracker:START");
			sqlMap = SqlConfig.getInstance().getSqlMap();
			//sqlMap.startTransaction();		
			Object o = sqlMap.insert("insertTracker", tracker);
			System.out.println("insert:"+o);
			//sqlMap.commitTransaction();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			//try{sqlMap.endTransaction();}
			//catch(Exception ignore){}
			logger.debug("WoodDB::insertTracker:END");
		}
	}
	
	
	/**
	 * insertTracker - Insert tracker
	 * @param tracker - New tracker
	 * @throws ServiceException
	 */
	public static void insertTracker2(Tracker tracker)
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
	@SuppressWarnings("unchecked")	
	public static HashMap<String, String> getAllConfig()
			throws ServiceSecurityException, ServiceException {
		try {
			logger.debug("WoodDB::getAllConfig:START");
			SqlMapClient sqlMap = SqlConfig.getInstance().getSqlMap();
			List<Config> configs = (List<Config>) sqlMap.queryForList("getConfig");
			HashMap<String, String> rets = new HashMap<String, String>();
			for( Config config : configs){
				if( Constants.s_PAYPAL_USER_NAME.equals(config.getKey()) || 
						Constants.s_PAYPAL_PWD.equals(config.getKey()) || 
						Constants.s_PAYPAL_SIGNATURE.equals(config.getKey()) )
				{
					config.setValue(EcryptoDataProvider.getInstance()
						.getEcrypto().decrypt(config.getValue()));
				}		
				//System.out.println("after key["+config.getKey()+"] value["+config.getValue()+"]");
				rets.put(config.getKey(), config.getValue());
			}
			return rets;

		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("WoodDB::getAllConfig:END");
		}
	}
	
	
	/**
	 * getAllConfig - All data in Configuration table
	 * @return HashMap - List of configuration by KEY
	 * @throws ServiceException
	 */
	public static HashMap<String, String> getAllConfig2()
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
		System.out.println("---------- insertTracker--------");
		Tracker t = new Tracker();
		t.setCategoryId(1);
		t.setClientId("10.10.10.255");
		t.setProductId(35);
		t.setProductType("WOOD");
		
		UtilDB.insertTracker(t);		
		
		System.out.println("---------- getConfig --------");
		EcryptoDataProvider.init("ZUJpeiBpcyBhIGdsb2JhbCB0cmFkaW5nIGNvbXBhbnkgZm9yIGJvdGggaW1wb3J0IGFuZCBleHBvcnQ=", "REVT");
		HashMap<String,String> rets = UtilDB.getAllConfig();
		
		System.out.println("size:"+rets.size());
	}
}
