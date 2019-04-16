package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ebiz.data.Shipping;
import com.ebiz.framework.data.ServiceException;

public class ShipDB {
	static final String s_SQL_QUERY_SHIPPING =
		" SELECT shipping_id, vendor, tracking_id, order_id, create_date " +
		" FROM Shipping WHERE order_id = ? ";

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
			System.out.println("ShipDB::getShipping:START");
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
		}
	}

	//Main method to test this class

	public static void main(String[] args) throws Exception
	{
		System.out.println("-------get shipping--------------");
		System.out.println(ShipDB.getShipping(1));
		
	}
}
