package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ebiz.data.Shipper;
import com.ebiz.data.Shipping;
import com.ebiz.framework.data.ServiceException;

public class ShipDB {
	static final String s_SQL_QUERY_SHIPPER =
		" SELECT vendor_id, name, type, cost, create_date FROM Shipper ";

	static final String s_SQL_QUERY_SHIPPING =
		" SELECT shipping_id, vendor, tracking_id, order_id, create_date " +
		" FROM Shipping WHERE order_id = ? ";
	
	
	static Logger logger = Logger.getLogger(ShipDB.class.getName());	

	/**
	 * getShipper - Lookup all shipping vendors
	 * @return Shipper[] - All Ship vendors
	 * @throws ServiceException
	 */
	public static Shipper[] getAllShippers()
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
				ship = new Shipping();
				ship.setId(rs.getInt(index++));
				ship.setVendor(rs.getString(index++));
				ship.setTrackingId(rs.getString(index++));
				ship.setOrderId(rs.getInt(index++));
				ship.setCreateDate(rs.getTimestamp(index++));
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

	//Main method to test this class

	public static void main(String[] args) throws Exception
	{
		logger.debug("-------get shipping--------------");
		logger.debug(ShipDB.getShipping(1));
		
	}
}
