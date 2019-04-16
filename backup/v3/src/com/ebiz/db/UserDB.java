package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ebiz.cache.EcryptoDataProvider;
import com.ebiz.data.Constants;
import com.ebiz.data.Permission;
import com.ebiz.data.User;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.framework.data.ServiceSecurityException;

public class UserDB {
	static final String s_SQL_VALIDATE_USER =
		" SELECT u.passwd, p.perm_id, p.name " +
		" FROM Users u, Permission p WHERE u.perm_id = p.perm_id AND u.email = ? ";
	
	static final String s_SQL_INSERT_USER = 
		" INSERT INTO Users (email, passwd, perm_id) VALUES (?,?,?) ";
	
	static Logger logger = Logger.getLogger(UserDB.class.getName());	
	
	/**
	 * validateUser - Validate login user
	 * @param email - Email address of user
	 * @param pwd - User password
	 * @return User - User profile
	 * @throws ServiceException
	 */
	public static User validateUser(String email, String pwd)
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
			logger.debug("UserDB::validateUser:END");
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

	//Main method to test this class

	public static void main(String[] args) throws Exception
	{
		logger.debug("-------get shipping--------------");
		logger.debug(UserDB.validateUser("phi2006@gmail.com", "test"));
		
		logger.debug("-------insert user--------------");
		Permission perm = new Permission("User","Web User");
		User user = new User("abc@a.com","test");
		user.setPermission(perm);
		UserDB db = new UserDB();
		db.insertUser(user);
	}
}
