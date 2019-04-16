package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ebiz.cache.EcryptoDataProvider;
import com.ebiz.data.Constants;
import com.ebiz.data.Customer;
import com.ebiz.data.Permission;
import com.ebiz.data.User;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.framework.data.ServiceSecurityException;

public class UserDB {
	static final String s_SQL_VALIDATE_USER =
		" SELECT u.passwd, p.perm_id, p.name, c.customer_id, c.first_name, c.last_name, c.contact_phone, " +
		"        c.contact_fax, c.bill_address1, c.bill_address2, c.bill_city, c.bill_state, c.bill_zip, c.bill_zip4, c.bill_country, " +
		"        c.ship_address1, c.ship_address2, c.ship_city, c.ship_state, c.ship_zip, c.ship_zip4, c.ship_country " +
		" FROM Users u, Customer c, Permission p " +
		" WHERE u.email = c.email AND u.perm_id = p.perm_id AND u.email = ? order by create_date desc ";

	static final String s_SQL_VALIDATE_ADMIN_USER =
		" SELECT u.passwd, p.perm_id, p.name " +
		" FROM Users u,Permission p " +
		" WHERE u.perm_id = p.perm_id AND u.email = ? ";
	
	
	static final String s_SQL_INSERT_USER = 
		" INSERT INTO Users (email, passwd, perm_id) VALUES (?,?,?) ";

	static final String s_SQL_UPDATE_USER = 
		" UPDATE Users set passwd = ?, perm_id = ? WHERE email = ? ";

	
	
	static Logger logger = Logger.getLogger(UserDB.class.getName());	
	
	/**
	 * validateUser - Validate login user
	 * @param email - Email address of user
	 * @param pwd - User password
	 * @return User - User profile
	 * @throws ServiceException
	 */
	public static User validateUser(String email, String pwd, boolean isValidate)
			throws ServiceSecurityException, ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			logger.debug("UserDB::validateUser:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_VALIDATE_USER);
			pstmt.setString(1, email.toLowerCase());

			rs = pstmt.executeQuery();

			int index = 1;
			User user = null;
			// Walk thru resultset
			if (rs.next()) {
				String password = EcryptoDataProvider.getInstance().getEcrypto().decrypt(rs.getString(index++));
				String permId = rs.getString(index++);
				String permDesc = rs.getString(index++);
				
				logger.debug("UserDB::validateUser:dbPwd["+password+"] Pwd["+pwd+"]");
				
				if( isValidate && !password.equals(pwd) )
					throw new ServiceSecurityException("Email or Password is not valid");
				
				Customer c = new Customer();
				c.setEmail(email);
				c.setCustomerId(rs.getInt(index++));
				c.setFirstName(rs.getString(index++));
				c.setLastName(rs.getString(index++));
				c.setContactPhone(rs.getString(index++));
				c.setContactFax(rs.getString(index++));
				c.setAddress1(rs.getString(index++));
				c.setAddress2(rs.getString(index++));
				c.setCity(rs.getString(index++));
				c.setState(rs.getString(index++));
				c.setZip(rs.getString(index++));
				c.setZip4(rs.getString(index++));
				c.setCountry(rs.getString(index++));
				c.setShipAddress1(rs.getString(index++));
				c.setShipAddress2(rs.getString(index++));
				c.setShipCity(rs.getString(index++));
				c.setShipState(rs.getString(index++));
				c.setShipZip(rs.getString(index++));
				c.setShipZip4(rs.getString(index++));
				c.setShipCountry(rs.getString(index++));
				
				user = new User(email,password);
				user.setCustomer(c);
				
				//Don't setup permission object unless it's not normal web user!
				if( !Constants.s_WEB_USER_PROFILE.equals(permId) ){
					Permission perm = new Permission(permId, permDesc);
					user.setPermission(perm);
				}
					
			}else{
				if( isValidate )
					throw new ServiceSecurityException("Email or Password is not valid");
				return null;
			}

			return user;
			
		} catch (SQLException sqle) {
			sqle.printStackTrace();
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
			logger.debug("UserDB::validateUser:END");
		}
	}
	
	/**
	 * validateUser - Validate login user
	 * @param email - Email address of user
	 * @param pwd - User password
	 * @return User - User profile
	 * @throws ServiceException
	 */
	public static User validateAdminUser(String email, String pwd)
			throws ServiceSecurityException, ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			logger.debug("UserDB::validateAdminUser:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_VALIDATE_ADMIN_USER);
			pstmt.setString(1, email.toLowerCase());

			rs = pstmt.executeQuery();

			int index = 1;
			User user = null;
			// Walk thru resultset
			if (rs.next()) {
				String password = EcryptoDataProvider.getInstance().getEcrypto().decrypt(rs.getString(index++));
				String permId = rs.getString(index++);
				String permDesc = rs.getString(index++);
				
				logger.debug("UserDB::validateAdminUser:dbPwd["+password+"] Pwd["+pwd+"]");
				
				if( !password.equals(pwd) )
					throw new ServiceSecurityException("Email or Password is not valid");
								
				user = new User(email,password);
				
				//Don't setup permission object unless it's not normal web user!
				if( !Constants.s_WEB_USER_PROFILE.equals(permId) ){
					Permission perm = new Permission(permId, permDesc);
					user.setPermission(perm);
				}
					
			}else{
				throw new ServiceSecurityException("Email or Password is not valid");
			}

			return user;
			
		} catch (SQLException sqle) {
			sqle.printStackTrace();
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
			logger.debug("UserDB::validateAdminUser:END");
		}
	}	

	/**
	 * insertUser - Insert User
	 * @param user - New User
	 * @throws ServiceException
	 */
	public void insertUser(User user)
			throws ServiceException 
	{
		Connection conn = null;
		try{
			conn = (DBConnection.getInstance()).getConnection();
			insertUser(conn, user);
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
	 * insertUser - Insert User
	 * @param user - New User
	 * @param conn - Database Connection
	 * @throws ServiceException
	 */
	public void insertUser(Connection conn, User user)
			throws ServiceException {
		PreparedStatement pstmt = null;
		try {
			logger.debug("UserDB::insertUser:START");
						
			pstmt = conn.prepareStatement(s_SQL_INSERT_USER);	
			
			pstmt.setString(1, user.getEmail().toLowerCase());
			pstmt.setString(2, EcryptoDataProvider.getInstance().getEcrypto().encrypt(user.getPassword()));
			pstmt.setString(3, user.getPermission().getCode());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to insert user.");
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
			try {
				pstmt.close();
			} catch (Exception ignore) {
			}
			logger.debug("UserDB::insertUser:END");
		}
	}		
	
	/**
	 * updateUser - Update User
	 * @param user - New User
	 * @throws ServiceException
	 */
	public void updateUser(User user)
			throws ServiceException 
	{
		Connection conn = null;
		try{
			conn = (DBConnection.getInstance()).getConnection();
			updateUser(conn, user);
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
	 * updateUser - Update User
	 * @param user - New User
	 * @param conn - Database Connection
	 * @throws ServiceException
	 */
	public void updateUser(Connection conn, User user)
			throws ServiceException {
		PreparedStatement pstmt = null;
		try {
			logger.debug("UserDB::updateUser:START");
						
			pstmt = conn.prepareStatement(s_SQL_UPDATE_USER);	
			
			pstmt.setString(1, EcryptoDataProvider.getInstance().getEcrypto().encrypt(user.getPassword()));
			pstmt.setString(2, user.getPermission().getCode());
			pstmt.setString(3, user.getEmail().toLowerCase());			
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to update user " + user.getEmail());
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
			try {
				pstmt.close();
			} catch (Exception ignore) {
			}
			logger.debug("UserDB::updateUser:END");
		}
	}			

	//Main method to test this class

	public static void main(String[] args) throws Exception
	{
		logger.debug("-------get shipping--------------");
		logger.debug(UserDB.validateUser("phi2006@gmail.com", "test", true));
		
		logger.debug("-------insert user--------------");
		Permission perm = new Permission("User","Web User");
		User user = new User("abc@a.com","test");
		user.setPermission(perm);
		UserDB db = new UserDB();
		db.insertUser(user);
	}
}
