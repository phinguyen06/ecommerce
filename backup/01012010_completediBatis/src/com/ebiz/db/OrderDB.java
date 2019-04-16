package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//import org.apache.log4j.Logger;

import com.ebiz.cache.EcryptoDataProvider;
import com.ebiz.cache.LoggerDataProvider;
import com.ebiz.cache.SqlConfig;
import com.ebiz.cache.StatusCodeDataProvider;
import com.ebiz.data.Constants;
import com.ebiz.data.Customer;
import com.ebiz.data.Order;
import com.ebiz.data.OrderWoodProduct;
import com.ebiz.data.Payment;
import com.ebiz.data.Permission;
import com.ebiz.data.Shipper;
import com.ebiz.data.Shipping;
import com.ebiz.data.Status;
import com.ebiz.data.User;
import com.ebiz.data.WoodProduct;
import com.ebiz.framework.data.ServiceException;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * OrderDB is a database operation class.  It's reponsible to query/update database
 * tables for certain operation.
 *
 */
public class OrderDB {

	static final String s_SQL_INSERT_CUSTOMER =
		" INSERT INTO Customer ( first_name, last_name, email, contact_phone, contact_fax, " +
		"	bill_address1, bill_address2, bill_city, bill_state, bill_zip, bill_zip4, " +
		"	bill_country, ship_address1, ship_address2, ship_city, ship_state, ship_zip, ship_zip4, " +
		"	ship_country, create_date ) " +
		" VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate() ) ";	

	static final String s_SQL_UPDATE_CUSTOMER =
		" UPDATE Customer " +
		"        SET first_name = ?, " + 
		"            last_name = ?, " +
		"            email = ?, " +
		"            contact_phone = ?, " +
		"            contact_fax = ?, " +
		"	         bill_address1 = ?, " +
		"            bill_address2 = ?, " +
		"            bill_city = ?, " +
		"            bill_state = ?, " +
		"            bill_zip = ?, " +
		"            bill_zip4 = ?, " +
		"	         bill_country = ?, " +
		"            ship_address1 = ?, " +
		"            ship_address2 = ?, " +
		"            ship_city = ?, " +
		"            ship_state = ?, " +
		"            ship_zip = ?, " +
		"            ship_zip4 = ?, " +
		"	         ship_country = ?, " + 
		"            update_date = sysdate() " +
		" WHERE customer_id = ? ";	
	
	
	static final String s_SQL_SELECT_MAX_CUSTOMER = 
		" SELECT MAX(customer_id) FROM Customer ";

	static final String s_SQL_SELECT_MAX_PAYMENT = 
		" SELECT MAX(payment_id) FROM Payment ";
	
	static final String s_SQL_SELECT_MAX_ORDER = 
		" SELECT MAX(order_id) FROM Orders ";
	
	static final String s_SQL_INSERT_PAYMENT = 
		"	INSERT INTO Payment ( card_holder_name, card_type, " +
		"   	card_number, card_exp_date, card_cvv, amount, create_date ) " +
		"	VALUES (?,?,?,?,?,?,sysdate() ) "; 

	static final String s_SQL_INSERT_ORDER = 
		"	INSERT INTO Orders ( customer_id, payment_id, product_type, amount, comments, status, client_id, create_date ) " +
		"	VALUES ( ?,?,?,?,?,?,?,sysdate() ) "; 
	
	static final String s_SQL_INSERT_ORDER_WOOD_PRODUCT = 
		"	INSERT INTO Orders_Wood_Product ( order_id, product_id, quantity, create_date ) " +
		"	VALUES ( ?,?,?,sysdate() ) "; 
		
	static final String s_SQL_UPDATE_ORDER = 
		"   UPDATE Orders set status = ?, " +
		"                     confirm_no = ?, " +
		"                     error_code = ?, " +
		"                     error_message = ?, " +
		"                     update_date = sysdate() " +
		"   WHERE  order_id = ? ";

	static final String s_SQL_UPDATE_PAYMENT = 
		"   UPDATE Payment set vendor_conf_no = ?, " +
		"                      vendor_response = ?, " + 
		"                     update_date = sysdate() " +
		"   WHERE  payment_id = ? ";
	
	static final String s_SQL_SELECT_ORDER = 
		"   SELECT 	c.customer_id, c.first_name, c.last_name, c.email, c.contact_phone, c.contact_fax, " +
		"			c.bill_address1, c.bill_address2, c.bill_city, " + 
		"			c.bill_state, c.bill_zip, c.bill_zip4, c.bill_country, c.ship_address1, " + 
		"			c.ship_address2, c.ship_city, c.ship_state, c.ship_zip, c.ship_zip4, " +
		"			c.ship_country, c.create_date, " + 
		"           o.product_type, o.comments, o.status, o.client_id, o.create_date, " + 
		"           p.payment_id, p.card_holder_name, p.card_type, p.card_number, " +
		"			p.card_exp_date, p.card_cvv, p.amount, p.vendor_conf_no, p.vendor_response, " + 
		"			p.update_date, p.create_date " + 
		"  FROM     Customer c, Orders o, Payment p " + 
		"  WHERE    o.customer_id = c.customer_id " + 
		"  AND      o.payment_id = p.payment_id " + 
		"  AND      o.order_id = ? ";	

	static final String s_SQL_SELECT_ORDERS_BY_STATUS = 
		"   SELECT 	c.customer_id, c.first_name, c.last_name, c.email, c.contact_phone, c.contact_fax, " +
		"			c.bill_address1, c.bill_address2, c.bill_city, " + 
		"			c.bill_state, c.bill_zip, c.bill_zip4, c.bill_country, c.ship_address1, " + 
		"			c.ship_address2, c.ship_city, c.ship_state, c.ship_zip, c.ship_zip4, " +
		"			c.ship_country, c.create_date, " + 
		"           o.order_id, o.product_type, o.comments, o.status, o.client_id, o.create_date, " + 
		"           p.payment_id, p.card_holder_name, p.card_type, p.card_number, " +
		"			p.card_exp_date, p.card_cvv, p.amount, p.vendor_conf_no, p.vendor_response, " + 
		"			p.update_date, p.create_date " + 
		"  FROM     Customer c, Orders o, Payment p " + 
		"  WHERE    o.customer_id = c.customer_id " + 
		"  AND      o.payment_id = p.payment_id " + 
		"  AND      o.status in ( ";	
	
	//static Logger logger = Logger.getLogger(OrderDB.class.getName());
	static LoggerDataProvider logger = LoggerDataProvider.getInstance();
	
	/**
	 * updateCustomer - Update this customer
	 * @param SqlMapClient - iBatis sqlmap to use as transaction 
	 * @param customer - Customer to update
	 * @throws ServiceException
	 */
	protected int updateCustomer(SqlMapClient sqlMap, Customer customer)
			throws ServiceException {
		//SqlMapClient sqlMap = null;
		try {
			logger.debug("OrderDB::updateCustomer:START");
			//sqlMap = SqlConfig.getInstance().getSqlMap();	
			sqlMap.update("updateCustomer", customer);
			return customer.getCustomerId();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("OrderDB::updateCustomer:END");
		}
	}	
	
	/**
	 * updateCustomer - Update this customer
	 * @param email - User email to update
	 * @throws ServiceException
	 */
	protected int updateCustomer2(Connection conn, Customer customer)
			throws ServiceException {
		PreparedStatement pstmt = null;
		try {
			logger.debug("OrderDB::updateCustomer:START");
			
			pstmt = conn.prepareStatement(s_SQL_UPDATE_CUSTOMER);

			int index = 1;
			pstmt.setString(index++, customer.getFirstName());
			pstmt.setString(index++, customer.getLastName());
			pstmt.setString(index++, customer.getEmail());
			pstmt.setString(index++, customer.getContactPhone());
			pstmt.setString(index++, customer.getContactFax());
			pstmt.setString(index++, customer.getAddress1());
			pstmt.setString(index++, customer.getAddress2());
			pstmt.setString(index++, customer.getCity());
			pstmt.setString(index++, customer.getState());
			pstmt.setString(index++, customer.getZip());
			pstmt.setString(index++, customer.getZip4());
			pstmt.setString(index++, customer.getCountry());
			pstmt.setString(index++, customer.getShipAddress1());
			pstmt.setString(index++, customer.getShipAddress2());
			pstmt.setString(index++, customer.getShipCity());
			pstmt.setString(index++, customer.getShipState());
			pstmt.setString(index++, customer.getShipZip());
			pstmt.setString(index++, customer.getShipZip4());
			pstmt.setString(index++, customer.getShipCountry());
			pstmt.setInt(index++, customer.getCustomerId());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to update customer " + customer.getEmail());
				
			return customer.getCustomerId();			
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
			try {
				pstmt.close();
			} catch (Exception ignore) {
			}
			logger.debug("OrderDB::updateCustomer:END");
		}
	}	
	
	/**
	 * insertCustomer - Lookup all wood category
	 * @param SqlMapClient - iBatis sqlmap to use as transaction
	 * @param customer - Customer object to insert into DB
	 * @return int - customerId
	 * @throws ServiceException
	 */
	protected int insertCustomer(SqlMapClient sqlMap, Customer customer)
			throws ServiceException {
		//SqlMapClient sqlMap = null;
		try {
			logger.debug("OrderDB::insertCustomer:START");
			//sqlMap = SqlConfig.getInstance().getSqlMap();	
			Object o = sqlMap.insert("insertCustomer", customer);
			System.out.println("insertCustomer:"+o);
			return ((Integer)0).intValue();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("OrderDB::insertCustomer:END");
		}
	}	
	
	
	/**
	 * insertCustomer - Lookup all wood category
	 * @return int - customerId
	 * @throws ServiceException
	 */
	protected int insertCustomer2(Connection conn, Customer customer)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			logger.debug("OrderDB::insertCustomer:START");
			pstmt = conn.prepareStatement(s_SQL_INSERT_CUSTOMER);					
			
			int index = 1;
			pstmt.setString(index++, customer.getFirstName());
			pstmt.setString(index++, customer.getLastName());
			pstmt.setString(index++, customer.getEmail());
			pstmt.setString(index++, customer.getContactPhone());
			pstmt.setString(index++, customer.getContactFax());
			pstmt.setString(index++, customer.getAddress1());
			pstmt.setString(index++, customer.getAddress2());
			pstmt.setString(index++, customer.getCity());
			pstmt.setString(index++, customer.getState());
			pstmt.setString(index++, customer.getZip());
			pstmt.setString(index++, customer.getZip4());
			pstmt.setString(index++, customer.getCountry());
			pstmt.setString(index++, customer.getShipAddress1());
			pstmt.setString(index++, customer.getShipAddress2());
			pstmt.setString(index++, customer.getShipCity());
			pstmt.setString(index++, customer.getShipState());
			pstmt.setString(index++, customer.getShipZip());
			pstmt.setString(index++, customer.getShipZip4());
			pstmt.setString(index++, customer.getShipCountry());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to insert customer " + customer.getEmail());			
			
			//get customer id from this insert
			pstmt = conn.prepareStatement(s_SQL_SELECT_MAX_CUSTOMER);
			rs = pstmt.executeQuery();
			int customerId = -1;
			// Walk thru resultset
			if (rs.next()) {
				customerId = rs.getInt(1);
			}
			
			if (customerId<0)
				throw new ServiceException("Unable to get customer id from this transaction");
						
			return customerId;			
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
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
			logger.debug("OrderDB::insertCustomer:END");
		}
	}
	
	/**
	 * insertPayment - Insert payment
	 * @param SqlMapClient - iBatis sqlmap to use as transaction
	 * @param payment - New Payment for this customer
	 * @return int - paymentId
	 * @throws ServiceException
	 */
	protected int insertPayment(SqlMapClient sqlMap, Payment payment)
			throws ServiceException {
		//SqlMapClient sqlMap = null;
		try {
			logger.debug("OrderDB::insertPayment:START");
			
			payment.setCardNumber(payment.getCardNumber().substring(payment.getCardNumber().length()-4,payment.getCardNumber().length()));
			
			//sqlMap = SqlConfig.getInstance().getSqlMap();	
			Object o = sqlMap.insert("insertPayment", payment);
			System.out.println("insertPayment:"+o);
			return ((Integer)0).intValue();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("OrderDB::insertPayment:END");
		}
	}		

	/**
	 * insertPayment - Insert payment
	 * @param payment - New Payment for this customer
	 * @return int - paymentId
	 * @throws ServiceException
	 */
	protected int insertPayment2(Connection conn, Payment payment)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			logger.debug("OrderDB::insertPayment:START");
			
			pstmt = conn.prepareStatement(s_SQL_INSERT_PAYMENT);	
			
			pstmt.setString(1, payment.getCardHolderName());
			pstmt.setString(2, payment.getCardType());
			//save the last 4 digits of the card only to prevent Encryption requirements
			pstmt.setString(3, payment.getCardNumber().substring(payment.getCardNumber().length()-4,payment.getCardNumber().length()));
			pstmt.setTimestamp(4, new Timestamp(payment.getCardExpDate().getTime()));
			pstmt.setString(5, payment.getCardCVV());
			pstmt.setDouble(6, payment.getAmount());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to insert payment.");
			
			//get customer id from this insert
			pstmt = conn.prepareStatement(s_SQL_SELECT_MAX_PAYMENT);
			rs = pstmt.executeQuery();
			int paymentId = -1;
			// Walk thru resultset
			if (rs.next()) {
				paymentId = rs.getInt(1);
			}
			
			if (paymentId<0)
				throw new ServiceException("Unable to get payment id from this transaction");
			
			return paymentId;			
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
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
			logger.debug("OrderDB::insertPayment:END");
		}
	}
	
	/**
	 * insertOrder - Insert Order
	 * @param SqlMapClient - iBatis sqlmap to use as transaction
	 * @param Order - New Transaction for this customer
	 * @return int - OrderId
	 * @throws ServiceException
	 */
	protected int insertOrder(SqlMapClient sqlMap, Order order)
			throws ServiceException {
		//SqlMapClient sqlMap = null;
		try {
			logger.debug("OrderDB::insertOrder:START");
			//sqlMap = SqlConfig.getInstance().getSqlMap();	
			Object o = sqlMap.insert("insertOrder", order);
			System.out.println("insertOrder:"+o);
			return ((Integer)o).intValue();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("OrderDB::insertOrder:END");
		}
	}		
	
	/**
	 * insertOrder - Insert Order
	 * @param Order - New Transaction for this customer
	 * @return int - OrderId
	 * @throws ServiceException
	 */
	protected int insertOrder2(Connection conn, Order order)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			logger.debug("OrderDB::insertOrder:START");
			
			pstmt = conn.prepareStatement(s_SQL_INSERT_ORDER);	
			
			pstmt.setInt(1, order.getCustomer().getCustomerId());
			pstmt.setInt(2, order.getPayment().getPaymentId());
			pstmt.setString(3, order.getProductType());
			pstmt.setDouble(4, order.getAmount());
			pstmt.setString(5, order.getComments());
			pstmt.setString(6, order.getStatus());
			pstmt.setString(7, order.getClientId());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to insert transaction.");
			
			//get transaction id from this insert
			pstmt = conn.prepareStatement(s_SQL_SELECT_MAX_ORDER);
			rs = pstmt.executeQuery();
			int transactionId = -1;
			// Walk thru resultset
			if (rs.next()) {
				transactionId = rs.getInt(1);
			}
			
			if (transactionId<0)
				throw new ServiceException("Unable to get transaction id from this transaction");
			
			return transactionId;			
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
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
			logger.debug("OrderDB::insertOrder:END");
		}
	}
	
	/**
	 * insertOrderWoodProduct - ordering wood product
	 * @param SqlMapClient - iBatis sqlmap to use as transaction
	 * @param OrderWoodProduct - Wood product to be ordered
	 * @throws ServiceException
	 */
	protected void insertOrderWoodProduct(SqlMapClient sqlMap, OrderWoodProduct wp)
			throws ServiceException {
		//SqlMapClient sqlMap = null;
		try {
			logger.debug("OrderDB::insertOrderWoodProduct:START");
			//sqlMap = SqlConfig.getInstance().getSqlMap();	
			sqlMap.insert("insertOrderWoodProduct", wp);
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("OrderDB::insertOrderWoodProduct:END");
		}
	}		
	
	/**
	 * insertOrderWoodProduct - ordering wood product
	 * @param payment - New Payment for this customer
	 * @throws ServiceException
	 */
	protected void insertOrderWoodProduct2(Connection conn, OrderWoodProduct wp)
			throws ServiceException {
		PreparedStatement pstmt = null;
		try {
			logger.debug("OrderDB::insertOrderWoodProduct:START");
			
			pstmt = conn.prepareStatement(s_SQL_INSERT_ORDER_WOOD_PRODUCT);	
			
			pstmt.setInt(1, wp.getOrder().getOrderId());
			pstmt.setInt(2, wp.getWoodProduct().getProductId());
			pstmt.setInt(3, wp.getQuantity());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to order wood product.");
			
		} catch (SQLException sqle) {
			throw new ServiceException(sqle);
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
			try {
				pstmt.close();
			} catch (Exception ignore) {
			}
			logger.debug("OrderDB::insertOrderWoodProduct:END");
		}
	}	
	
	/**
	 * createOrder - Create Customer Order
	 * @param orderWoodProducts - List of orders for wood product for this customer
	 * @return int - transactionId
	 * @throws ServiceException
	 */
	public int createOrder(OrderWoodProduct[] orderWoodProducts)
			throws ServiceException {
		//Connection conn = null;
		SqlMapClient sqlMap = null;
		
		try {
			logger.debug("OrderDB::createOrder:START");
			
			//conn = (DBConnection.getInstance()).getConnection();
			//conn.setAutoCommit(false);
				
			sqlMap = SqlConfig.getInstance().getSqlMap();
			sqlMap.startTransaction();
			
			
			//STEP 1: Create customer or update customer
			int customerId;
			boolean isUpdate = false;
			if(  orderWoodProducts[0].getOrder().getCustomer().getCustomerId() > 0 ){
				customerId = updateCustomer(sqlMap, orderWoodProducts[0].getOrder().getCustomer());
				isUpdate = true;
			}else
				customerId = insertCustomer(sqlMap, orderWoodProducts[0].getOrder().getCustomer());
			orderWoodProducts[0].getOrder().getCustomer().setCustomerId(customerId);
						
			Order order = orderWoodProducts[0].getOrder();
			order.getCustomer().setCustomerId(customerId);
			
			System.out.println("Step 2");
			
			//STEP 2: Create payment
			int paymentId = insertPayment(sqlMap, orderWoodProducts[0].getOrder().getPayment());
			order.getPayment().setPaymentId(paymentId);
			
			System.out.println("Step 3");
			
			//STEP 3: Create Order			
			int orderId = insertOrder(sqlMap, orderWoodProducts[0].getOrder());
			order.setOrderId(orderId);
			
			System.out.println("Step 4");
			
			//STEP 4: Create Order for Wood Products
			
			for( int i=0; i<orderWoodProducts.length; i++ ){
				orderWoodProducts[i].setOrder(order);
				insertOrderWoodProduct(sqlMap, orderWoodProducts[i]);
			}
			
			System.out.println("Step 5");
			
			//STEP 5: Create WEB user in the system
			Permission perm = new Permission(Constants.s_WEB_USER_PROFILE, "Web User");
			User user = new User(order.getCustomer().getEmail(), order.getCustomer().getPassword());
			user.setPermission(perm);
			
			UserDB udb = new UserDB();
			if( isUpdate )
				udb.updateUser(sqlMap, user);
			else
				udb.insertUser(sqlMap, user);
			
			System.out.println("Step 6");
			
			//STEP 6: Create Shipping requirement
			ShipDB sdb = new ShipDB();
			sdb.insertShipping(sqlMap, order.getShipping());
			
			//STEP 7: COMMIT SUCCESSFUL Order
			//conn.commit();
			sqlMap.commitTransaction();
			
			return orderId;
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			try{
				sqlMap.endTransaction();
				//conn.rollback();
			}catch(SQLException ignore){}
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			//try{
			//	conn.rollback();
			//}catch(SQLException ignore){}
			throw new ServiceException(e);
		} finally {
			try {
				sqlMap.endTransaction();
				//conn.close();
			} catch (Exception ignore) {
			}
			logger.debug("OrderDB::createOrder:END");
		}
	}	
	
	/**
	 * updateOrder - Update order table
	 * @param order - New Payment for this customer
	 * @throws ServiceException
	 */
	public void updateOrder(Order order)
			throws ServiceException {
		SqlMapClient sqlMap = null;
		try {
			logger.debug("OrderDB::updateOrder:START");
			sqlMap = SqlConfig.getInstance().getSqlMap();	
			//order.setOrderId(53);
			//order.setStatus("S");
			sqlMap.update("updateOrder", order);
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("OrderDB::updateOrder:END");
		}
	}		
	
	/**
	 * updateOrder - Update order table
	 * @param order - New Payment for this customer
	 * @throws ServiceException
	 */
	public void updateOrder2(Order order)
			throws ServiceException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			logger.debug("OrderDB::updateOrder:START");
			
			conn = (DBConnection.getInstance()).getConnection();
			pstmt = conn.prepareStatement(s_SQL_UPDATE_ORDER);	
			
			pstmt.setString(1, order.getStatus());
			pstmt.setString(2, order.getConfirmationNo());
			pstmt.setString(3, order.getErrorCode());
			pstmt.setString(4, order.getErrorMessage());
			pstmt.setInt(5, order.getOrderId());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to update order.");			
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
			logger.debug("OrderDB::updateOrder:END");
		}
	}	
	
	/**
	 * updatePayment - Update order table
	 * @param paymentId - Payment Id
	 * @param vendorConfNo - Vendor confirmation number for this payment
	 * @throws ServiceException
	 */
	public void updatePayment(int paymentId, String vendorConfNo, String vendorResponse)
			throws ServiceException {
		SqlMapClient sqlMap = null;
		try {
			logger.debug("OrderDB::updatePayment:START");
			Map<String,String> paramM = new HashMap<String,String>();  
			paramM.put("paymentId", String.valueOf(paymentId));  
			paramM.put("vendorConfNo", vendorConfNo);
			paramM.put("vendorResponse", vendorResponse);
			sqlMap = SqlConfig.getInstance().getSqlMap();	
			sqlMap.update("updatePayment", paramM);
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("OrderDB::updatePayment:END");
		}
	}			
	
	/**
	 * updatePayment - Update order table
	 * @param paymentId - Payment Id
	 * @param vendorConfNo - Vendor confirmation number for this payment
	 * @throws ServiceException
	 */
	public void updatePayment2(int paymentId, String vendorConfNo, String vendorResponse)
			throws ServiceException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			logger.debug("OrderDB::updatePayment:START");
			
			conn = (DBConnection.getInstance()).getConnection();
			pstmt = conn.prepareStatement(s_SQL_UPDATE_PAYMENT);	
			
			pstmt.setString(1, vendorConfNo);
			pstmt.setString(2, vendorResponse);
			pstmt.setInt(3, paymentId);

			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to update order.");			
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
			logger.debug("OrderDB::updatePayment:END");
		}
	}	
	
	/**
	 * getOrder - Lookup all orders of wood product for customer by orderId
	 * @param orderId - Order Id to search Order
	 * @return Order - Order
	 * @throws ServiceException
	 */
	@SuppressWarnings("unchecked")
	public static Order getOrder(int orderId)
			throws ServiceException {
		try {
			logger.debug("OrderDB::getOrder:START");
			SqlMapClient sqlMap = SqlConfig.getInstance().getSqlMap();
			List<Order> list = (List<Order>) sqlMap.queryForList("getOrder");
			Order[] rets = new Order[list.size()];
			int i=0;
			for( Order order : list){
				rets[i++] = order;
			}
			
			if( rets.length > 0 )
				return rets[0];
			return null;

		} catch (SQLException sqle) {
			sqle.printStackTrace();
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		} finally {
			logger.debug("OrderDB::getOrder:END");
		}
	}	
	
	/**
	 * getOrder - Lookup all orders of wood product for customer by orderId
	 * @param orderId - Order Id to search Order
	 * @return Order - Order
	 * @throws ServiceException
	 */
	public static Order getOrder2(int orderId)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			logger.debug("OrderDB::getOrderWoodProducts:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_SELECT_ORDER);
			pstmt.setInt(1, orderId);
			rs = pstmt.executeQuery();

			int index = 1;
			Order order = new Order();
			Customer customer = new Customer();
			Payment payment = new Payment();
				
			// Walk thru resultset
			if (rs.next()) {		
				customer.setCustomerId(rs.getInt(index++));
				customer.setFirstName(rs.getString(index++));
				customer.setLastName(rs.getString(index++));
				customer.setEmail(rs.getString(index++));
				customer.setContactPhone(rs.getString(index++));
				customer.setContactFax(rs.getString(index++));
				customer.setAddress1(rs.getString(index++));
				customer.setAddress2(rs.getString(index++));
				customer.setCity(rs.getString(index++));
				customer.setState(rs.getString(index++));
				customer.setZip(rs.getString(index++));
				customer.setZip4(rs.getString(index++));
				customer.setCountry(rs.getString(index++));
				customer.setShipAddress1(rs.getString(index++));
				customer.setShipAddress2(rs.getString(index++));
				customer.setShipCity(rs.getString(index++));
				customer.setShipState(rs.getString(index++));
				customer.setShipZip(rs.getString(index++));
				customer.setShipZip4(rs.getString(index++));
				customer.setShipCountry(rs.getString(index++));
				customer.setCreateDate(rs.getTimestamp(index++));
				
				order.setProductType(rs.getString(index++));
				order.setComments(rs.getString(index++));
				order.setStatus(rs.getString(index++));
				order.setClientId(rs.getString(index++));
				order.setCreateDate(rs.getTimestamp(index++));
				
				payment.setPaymentId(rs.getInt(index++));
				payment.setCardHolderName(rs.getString(index++));
				payment.setCardType(rs.getString(index++));
				payment.setCardNumber(rs.getString(index++));
				payment.setCardExpDate(rs.getTimestamp(index++));
				payment.setCardCVV(rs.getString(index++));
				payment.setAmount(rs.getDouble(index++));		
				payment.setVendorConfirmationNo(rs.getString(index++));
				payment.setVendorResponse(rs.getString(index++));
				payment.setUpdateDate(rs.getTimestamp(index++));
				payment.setCreateDate(rs.getTimestamp(index++));

				order.setCustomer(customer);
				order.setPayment(payment);
								
				index = 1;
			}
			
			return order;
			
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
			logger.debug("OrderDB::getOrderWoodProducts:END");
		}
	}			
	
	/**
	 * getOrder - Lookup all orders of wood product for customer by orderId
	 * @param orderId - Order Id to search Order
	 * @return Order[] - List of Order by Status
	 * @throws ServiceException
	 */
	public static Order[] getOrderByStatus(Status[] status)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			logger.debug("OrderDB::getOrderByStatus:START");
			conn = (DBConnection.getInstance()).getConnection();

			String sql = "";
			for( int i=0; i<status.length; i++ ){
				sql += "'" + status[i].getCode() + "',";
			}
			//remove the last comma
			sql = sql.substring(0,sql.length()-1);
			//logger.debug("sql:"+sql);
			
			sql = s_SQL_SELECT_ORDERS_BY_STATUS + sql + " ) " ;
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();

			int index = 1;
			Order order = new Order();
			Customer customer = new Customer();
			Payment payment = new Payment();
			ArrayList<Order> list = new ArrayList<Order>();
			// Walk thru resultset
			if (rs.next()) {		
				customer.setCustomerId(rs.getInt(index++));
				customer.setFirstName(rs.getString(index++));
				customer.setLastName(rs.getString(index++));
				customer.setEmail(rs.getString(index++));
				customer.setContactPhone(rs.getString(index++));
				customer.setContactFax(rs.getString(index++));
				customer.setAddress1(rs.getString(index++));
				customer.setAddress2(rs.getString(index++));
				customer.setCity(rs.getString(index++));
				customer.setState(rs.getString(index++));
				customer.setZip(rs.getString(index++));
				customer.setZip4(rs.getString(index++));
				customer.setCountry(rs.getString(index++));
				customer.setShipAddress1(rs.getString(index++));
				customer.setShipAddress2(rs.getString(index++));
				customer.setShipCity(rs.getString(index++));
				customer.setShipState(rs.getString(index++));
				customer.setShipZip(rs.getString(index++));
				customer.setShipZip4(rs.getString(index++));
				customer.setShipCountry(rs.getString(index++));
				customer.setCreateDate(rs.getTimestamp(index++));
				
				order.setOrderId(rs.getInt(index++));
				order.setProductType(rs.getString(index++));
				order.setComments(rs.getString(index++));
				order.setStatus(rs.getString(index++));
				order.setClientId(rs.getString(index++));
				order.setCreateDate(rs.getTimestamp(index++));
				
				payment.setPaymentId(rs.getInt(index++));
				payment.setCardHolderName(rs.getString(index++));
				payment.setCardType(rs.getString(index++));
				payment.setCardNumber(rs.getString(index++));
				payment.setCardExpDate(rs.getTimestamp(index++));
				payment.setCardCVV(rs.getString(index++));
				payment.setAmount(rs.getDouble(index++));		
				payment.setVendorConfirmationNo(rs.getString(index++));
				payment.setVendorResponse(rs.getString(index++));
				payment.setUpdateDate(rs.getTimestamp(index++));
				payment.setCreateDate(rs.getTimestamp(index++));

				order.setCustomer(customer);
				order.setPayment(payment);
				
				list.add(order);
								
				index = 1;
			}
			
			Order[] rets = new Order[list.size()];
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
			logger.debug("OrderDB::getOrderByStatus:END");
		}
	}		
	
	//Main method to test this class

	public static void main(String[] args) throws Exception
	{
		EcryptoDataProvider.init("ZUJpeiBpcyBhIGdsb2JhbCB0cmFkaW5nIGNvbXBhbnkgZm9yIGJvdGggaW1wb3J0IGFuZCBleHBvcnQ=", "REVT");
		
		Customer customer = new Customer();
		
		//customer.setCustomerId(35);	//enable this row if we need to update instead of insert
		customer.setFirstName("PHI");
		customer.setLastName("NGUYEN");
		customer.setEmail("p2@g.com");
		customer.setContactPhone("2062260043");
		customer.setContactFax("2062260043");
		customer.setPassword("passwd");
		customer.setAddress1("123 main st");
		customer.setAddress2(" line 2");
		customer.setCity("olympia");
		 customer.setState("wa");
		 customer.setZip("98503");
		 customer.setZip4("4445");
		 customer.setCountry("USA");
		 customer.setShipAddress1("124 main st");
		 customer.setShipAddress2(" line 2");
		 customer.setShipCity("lacey");
		 customer.setShipState("wa");
		 customer.setShipZip("98504");
		 customer.setShipZip4("9999");
		 customer.setShipCountry("CA");

		java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("MM/yyyy");
		
		Payment payment = new Payment();
		payment.setCardHolderName("PHI NGUYEN");
		payment.setCardType("VS");
		payment.setCardNumber("01010101010101");
		payment.setCardCVV("1111");
		payment.setCardExpDate(fm.parse("12/2010"));
		payment.setAmount(29.99);
		 		 
		Order order = new Order();
		order.setProductType("WOOD");
		order.setComments("comment me not");
		
		order.setCustomer(customer);
		order.setPayment(payment);
		
		Shipper vendor = new Shipper();
		vendor.setId(1);
		Shipping shipping = new Shipping();
		shipping.setVendor(vendor);
		order.setShipping(shipping);
		
		WoodProduct wp = new WoodProduct();
		wp.setProductId(1);
		OrderWoodProduct[] owp = new OrderWoodProduct[1];
		owp[0] = new OrderWoodProduct(order, wp, 2, new java.util.Date());
		
		OrderDB db = new OrderDB();
		int orderId = db.createOrder(owp);
	
		System.out.println("OrderId: "+ orderId);
		logger.debug("OrderId: "+ orderId);
		
		logger.debug("-------get orders by status --------------");
		System.out.println("-------get orders by status --------------");

		StatusCodeDataProvider.init();
		Order[] orders = OrderDB.getOrderByStatus(StatusCodeDataProvider.getInstance().getStatuses(true));
		for( int i=0; i<orders.length; i++ ){
			logger.debug(orders[i].toString());
			System.out.println(orders[i].toString());
		}
		
		System.out.println("update order");
		
		db.updateOrder(order);
		
		System.out.println("update payment");
		
		db.updatePayment(58, "ABC", "ABC response");
		
		System.out.println(OrderDB.getOrder(59));
	}
}
