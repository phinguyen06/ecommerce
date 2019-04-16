package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.ebiz.cache.SqlConfig;
import com.ebiz.data.Shipper;
import com.ebiz.data.Shipping;
import com.ebiz.framework.data.ServiceException;
import com.ibatis.sqlmap.client.SqlMapClient;

public class ShipDB {
	static final String s_SQL_QUERY_SHIPPER =
		" SELECT vendor_id, name, type, cost, create_date FROM Shipper s ";

	static final String s_SQL_QUERY_SHIPPING =
		" SELECT v.vendor_id, v.name, v.type, v.cost, s.shipping_id, s.tracking_id, s.order_id, s.create_date " +
		" FROM Shipping s, Shipper v WHERE s.order_id = ? AND s.vendor_id = v.vendor_id ";
	
	static final String s_SQL_INSERT_SHIPPING = 
		" INSERT INTO Shipping (vendor_id, order_id, create_date) VALUES ( ?,?,sysdate() ) ";
	
	static Logger logger = Logger.getLogger(ShipDB.class.getName());	

	/**
	 * getShipper - Lookup all shipping vendors
	 * @return Shipper[] - All Ship vendors
	 * @throws ServiceException
	 */
	@SuppressWarnings("unchecked")
	public static Shipper[] getAllShippers()
			throws ServiceException {
		try {
			logger.debug("ShipDB::getAllShippers:START");
			SqlMapClient sqlMap = SqlConfig.getInstance().getSqlMap();
			List<Shipper> list = (List<Shipper>) sqlMap.queryForList("getShipper");
			Shipper[] rets = new Shipper[list.size()];
			int i=0;
			for( Shipper item : list){
				rets[i++] = item;
			}
			return rets;

		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("ShipDB::getAllShippers:END");
		}
	}
	
	/**
	 * getShipper - Lookup all shipping vendors
	 * @return Shipper[] - All Ship vendors
	 * @throws ServiceException
	 */
	public static Shipper[] getAllShippers2()
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			logger.debug("ShipDB::getAllShippers:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_QUERY_SHIPPER);

			rs = pstmt.executeQuery();

			int index = 1;
			Shipper shipper = null;
			ArrayList<Shipper> list = new ArrayList<Shipper>();
			// Walk thru resultset
			while (rs.next()) {
				shipper = new Shipper();
				shipper.setId(rs.getInt(index++));
				shipper.setName(rs.getString(index++));
				shipper.setType(rs.getString(index++));
				shipper.setCost(rs.getDouble(index++));
				shipper.setCreateDate(rs.getTimestamp(index++));
				
				list.add(shipper);
				index = 1;
			}

			Shipper[] rets = new Shipper[list.size()];
			return list.toArray(rets);
			
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
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
			logger.debug("ShipDB::getAllShippers:END");
		}
	}
	
	
	/**
	 * getShipping - Lookup shipping info for this order
	 * @param orderId - Order number to search for shipping
	 * @return Shipping - Ship info for this order
	 * @throws ServiceException
	 */
	public static Shipping getShipping(int orderId)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			logger.debug("ShipDB::getShipping:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_QUERY_SHIPPING);
			pstmt.setInt(1, orderId);

			rs = pstmt.executeQuery();

			int index = 1;
			Shipping ship = null;
			// Walk thru resultset
			if (rs.next()) {
				Shipper vendor = new Shipper();
				vendor.setId(rs.getInt(index++));
				vendor.setName(rs.getString(index++));
				vendor.setType(rs.getString(index++));
				vendor.setCost(rs.getDouble(index++));
				
				ship = new Shipping();
				ship.setId(rs.getInt(index++));
				ship.setTrackingId(rs.getString(index++));
				ship.setOrderId(rs.getInt(index++));
				ship.setCreateDate(rs.getTimestamp(index++));
				ship.setVendor(vendor);
			}

			return ship;
			
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
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
			logger.debug("ShipDB::getShipping:END");
		}
	}
	
	/**
	 * insertShipping - Insert Shipping
	 * @param ship - New shipping data
	 * @throws ServiceException
	 */
	public void insertShipping(SqlMapClient sqlMap, Shipping ship)
			throws ServiceException {
		//SqlMapClient sqlMap = null;
		try {
			logger.debug("ShipDB::insertShipping:START");
			//sqlMap = SqlConfig.getInstance().getSqlMap();	
			sqlMap.insert("insertShipping", ship);
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("ShipDB::insertShipping:END");
		}
	}		
	
	/**
	 * insertShipping - Insert Shipping
	 * @param ship - New shipping data
	 * @throws ServiceException
	 */
	public void insertShipping2(Shipping ship)
			throws ServiceException 
	{
		Connection conn = null;
		try{
			conn = (DBConnection.getInstance()).getConnection();
			//insertShipping(conn, ship);
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
			try {
				conn.close();
			} catch (Exception ignore) {
			}
		}
	}		

	/**
	 * insertShipping - Insert Shipping 
	 * @param ship - New Shipping data
	 * @param conn - Database Connection
	 * @throws ServiceException
	 */
	public void insertShipping(Shipping ship)
		throws ServiceException 
	{
		try{
			SqlMapClient sqlMap = SqlConfig.getInstance().getSqlMap();
			insertShipping(sqlMap, ship);
		}
		catch(ServiceException se){
			throw se;
		}
		catch(Exception e){
			throw new ServiceException(e);
		}
	}
	
	/**
	 * insertShipping - Insert Shipping 
	 * @param ship - New Shipping data
	 * @param conn - Database Connection
	 * @throws ServiceException
	 */
	public void insertShipping2(Connection conn, Shipping ship)
			throws ServiceException {
		PreparedStatement pstmt = null;
		try {
			logger.debug("ShipDB::insertShipping:START");
						
			pstmt = conn.prepareStatement(s_SQL_INSERT_SHIPPING);	
			
			pstmt.setInt(1, ship.getVendor().getId());
			pstmt.setInt(2, ship.getOrderId());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to insert shipping.");
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
			try {
				pstmt.close();
			} catch (Exception ignore) {
			}
			logger.debug("ShipDB::insertShipping:END");
		}
	}			
	//Main method to test this class

	public static void main(String[] args) throws Exception
	{
		logger.debug("-------get all shippers--------------");
		System.out.println("-------get all shippers--------------");
		Shipper[] shippers = ShipDB.getAllShippers();
		for( int i=0; i<shippers.length; i++ ){
			System.out.println(shippers[i].toString());
		}
		
		/*	
		logger.debug("-------get shipping--------------");
		logger.debug("-------get shipping--------------");
		Shipping shipping = ShipDB.getShipping(1); 
		logger.debug(shipping.toString());
		System.out.println(shipping.toString());
		*/
		
	}
}
