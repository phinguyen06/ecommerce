package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ebiz.data.State;
import com.ebiz.data.Status;
import com.ebiz.framework.data.ServiceException;

/**
 * ReferenceDB is a database operation class.  It's reponsible to query database
 * tables for certain operation.
 *
 */
public class ReferenceDB {

	static final String s_SQL_QUERY_ALL_STATES =
		" SELECT code, name, country "
			+ " FROM State ORDER BY name ";

	static final String s_SQL_QUERY_ALL_STATES_BY_COUNTRY =
		" SELECT code, name, country "
			+ " FROM State WHERE country = ? ORDER BY name ";
	
	static final String s_SQL_QUERY_STATUS =
		" SELECT code, description FROM STATUS ORDER BY code ";	
	
	/**
	 * getAllStates - Lookup all states
	 * @return State[] - Array of states in the system
	 * @throws ServiceException
	 */
	public static State[] getStates()
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("ReferenceDB::getStates:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_QUERY_ALL_STATES);

			rs = pstmt.executeQuery();

			int index = 1;
			ArrayList<State> list = new ArrayList<State>();
			// Walk thru resultset
			while (rs.next()) {
				list.add(new State(
						rs.getString(index++),
						rs.getString(index++),
						rs.getString(index++)));
				index = 1;
			}

			State[] rets = new State[list.size()];
			rets = list.toArray(rets);
			return rets;
			
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

	/**
	 * getAllStates - Lookup all states
	 * @param country - Country code
	 * @return State[] - Array of states in the system
	 * @throws ServiceException
	 */
	public static State[] getStates(String country)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("ReferenceDB::getStates:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_QUERY_ALL_STATES_BY_COUNTRY);
			pstmt.setString(1, country);
			
			rs = pstmt.executeQuery();

			int index = 1;
			ArrayList<State> list = new ArrayList<State>();
			// Walk thru resultset
			while (rs.next()) {
				list.add(new State(
						rs.getString(index++),
						rs.getString(index++),
						rs.getString(index++)));
				index = 1;
			}

			State[] rets = new State[list.size()];
			rets = list.toArray(rets);
			return rets;
			
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
	
	/**
	 * getAllStatuses - Lookup all order status
	 * @return Status[] - Array of Status in the system
	 * @throws ServiceException
	 */
	public static Status[] getAllStatuses()
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("WoodDB::getAllStatuses:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_QUERY_STATUS);

			rs = pstmt.executeQuery();

			int index = 1;
			ArrayList<Status> list = new ArrayList<Status>();
			// Walk thru resultset
			while (rs.next()) {
				list.add(new Status(
						rs.getString(index++),
						rs.getString(index++)));
				index = 1;
			}

			Status[] rets = new Status[list.size()];
			rets = list.toArray(rets);
			return rets;
			
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
		System.out.println("-------get all states--------------");
		
		State[] s = ReferenceDB.getStates();
		for( int i=0; i<s.length; i++ ){
			System.out.println("["+i+"] state["+s[i].getCode()+"]");
		}

		System.out.println("-------get all states by USA--------------");
		
		s = ReferenceDB.getStates("USA");
		for( int i=0; i<s.length; i++ ){
			System.out.println("["+i+"] state["+s[i].getCode()+"]");
		}
	
		
		System.out.println("---------Status---------");
		Status[] status = ReferenceDB.getAllStatuses();
		for( int i=0; i<status.length; i++){
			System.out.println(status[i].toString());
		}
		
	}
}
