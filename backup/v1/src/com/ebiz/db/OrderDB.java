package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.ebiz.data.Customer;
import com.ebiz.data.Order;
import com.ebiz.data.OrderWoodProduct;
import com.ebiz.data.Payment;
import com.ebiz.data.WoodCategory;
import com.ebiz.data.WoodProduct;
import com.ebiz.framework.data.ServiceException;

/**
 * OrderDB is a database operation class.  It's reponsible to query/update database
 * tables for certain operation.
 *
 */
public class OrderDB {

 
	static final String s_SQL_INSERT_CUSTOMER =
		" INSERT INTO Customer ( first_name, last_name, email, contact_phone, contact_fax, " +
		"	account_password, bill_address1, bill_address2, bill_city, bill_state, bill_zip, bill_zip4, " +
		"	bill_country, ship_address1, ship_address2, ship_city, ship_state, ship_zip, ship_zip4, " +
		"	ship_country, create_date ) " +
		" VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate() ) ";	

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
		"	INSERT INTO Orders ( customer_id, payment_id, product_type, comments, status, client_id, create_date ) " +
		"	VALUES ( ?,?,?,?,?,?,sysdate() ) "; 
	
	static final String s_SQL_INSERT_ORDER_WOOD_PRODUCT = 
		"	INSERT INTO Orders_Wood_Product ( order_id, product_id, quantity, create_date ) " +
		"	VALUES ( ?,?,?,sysdate() ) "; 
		
	static final String s_SQL_UPDATE_ORDER = 
		"   UPDATE Orders set status = ?, " +
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
		"			c.account_password, c.bill_address1, c.bill_address2, c.bill_city, " + 
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
	
	/**
	 * insertCustomer - Lookup all wood category
	 * @return int - customerId
	 * @throws ServiceException
	 */
	protected int insertCustomer(Connection conn, Customer customer)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			System.out.println("OrderDB::insertCustomer:START");
			
			pstmt = conn.prepareStatement(s_SQL_INSERT_CUSTOMER);

			pstmt.setString(1, customer.getFirstName());
			pstmt.setString(2, customer.getLastName());
			pstmt.setString(3, customer.getEmail());
			pstmt.setString(4, customer.getContactPhone());
			pstmt.setString(5, customer.getContactFax());
			pstmt.setString(6, customer.getPassword());
			pstmt.setString(7, customer.getAddress1());
			pstmt.setString(8, customer.getAddress2());
			pstmt.setString(9, customer.getCity());
			pstmt.setString(10, customer.getState());
			pstmt.setString(11, customer.getZip());
			pstmt.setString(12, customer.getZip4());
			pstmt.setString(13, customer.getCountry());
			pstmt.setString(14, customer.getShipAddress1());
			pstmt.setString(15, customer.getShipAddress2());
			pstmt.setString(16, customer.getShipCity());
			pstmt.setString(17, customer.getShipState());
			pstmt.setString(18, customer.getShipZip());
			pstmt.setString(19, customer.getShipZip4());
			pstmt.setString(20, customer.getShipCountry());
			
			pstmt.execute();
			
			if(pstmt.getUpdateCount()<1)
				throw new ServiceException("Unable to insert question.");
			
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
		}
	}

	/**
	 * insertPayment - Insert payment
	 * @param payment - New Payment for this customer
	 * @return int - paymentId
	 * @throws ServiceException
	 */
	protected int insertPayment(Connection conn, Payment payment)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			System.out.println("OrderDB::insertPayment:START");
			
			pstmt = conn.prepareStatement(s_SQL_INSERT_PAYMENT);	
			
			pstmt.setString(1, payment.getCardHolderName());
			pstmt.setString(2, payment.getCardType());
			//save the last 4 digits of the card only to prevent Encryption requirements
			pstmt.setString(3, payment.getCardNumber().substring(0,payment.getCardNumber().length()-4));
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
		}
	}
	
	/**
	 * insertOrder - Insert Order
	 * @param Order - New Transaction for this customer
	 * @return int - OrderId
	 * @throws ServiceException
	 */
	protected int insertOrder(Connection conn, Order order)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			System.out.println("OrderDB::insertOrder:START");
			
			pstmt = conn.prepareStatement(s_SQL_INSERT_ORDER);	
			
			pstmt.setInt(1, order.getCustomer().getCustomerId());
			pstmt.setInt(2, order.getPayment().getPaymentId());
			pstmt.setString(3, order.getProductType());
			pstmt.setString(4, order.getComments());
			pstmt.setString(5, order.getStatus());
			pstmt.setString(6, order.getClientId());
			
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
		}
	}
	
	/**
	 * insertOrderWoodProduct - ordering wood product
	 * @param payment - New Payment for this customer
	 * @throws ServiceException
	 */
	protected void insertOrderWoodProduct(Connection conn, OrderWoodProduct wp)
			throws ServiceException {
		PreparedStatement pstmt = null;
		try {
			System.out.println("OrderDB::insertOrderWoodProduct:START");
			
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
			System.out.println("OrderDB::insertOrderWoodProduct:END");
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
		Connection conn = null;
		try {
			System.out.println("OrderDB::createOrder:START");
			
			conn = (DBConnection.getInstance()).getConnection();
			conn.setAutoCommit(false);
				
			//STEP 1: Create customer
			
			int customerId = insertCustomer(conn, orderWoodProducts[0].getOrder().getCustomer());
			orderWoodProducts[0].getOrder().getCustomer().setCustomerId(customerId);
			
			Order order = orderWoodProducts[0].getOrder();
			order.getCustomer().setCustomerId(customerId);
			
			//STEP 2: Create payment

			int paymentId = insertPayment(conn, orderWoodProducts[0].getOrder().getPayment());
			order.getPayment().setPaymentId(paymentId);
			
			
			//STEP 3: Create Order
			
			int orderId = insertOrder(conn, orderWoodProducts[0].getOrder());
			order.setOrderId(orderId);
			
			//STEP 4: Create Order for Wood Products
			
			for( int i=0; i<orderWoodProducts.length; i++ ){
				orderWoodProducts[i].setOrder(order);
				insertOrderWoodProduct(conn, orderWoodProducts[i]);
			}
			
			//STEP 5: COMMIT SUCCESSFUL Order
			conn.commit();
			
			return orderId;
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			try{
				conn.rollback();
			}catch(SQLException ignore){}
			throw new ServiceException(sqle);
		} catch (Exception e) {
			e.printStackTrace();
			try{
				conn.rollback();
			}catch(SQLException ignore){}
			throw new ServiceException(e);
		} finally {
			try {
				conn.close();
			} catch (Exception ignore) {
			}
		}
	}	
	
	/**
	 * updateOrder - Update order table
	 * @param order - New Payment for this customer
	 * @throws ServiceException
	 */
	public void updateOrder(Order order)
			throws ServiceException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			System.out.println("OrderDB::updateOrder:START");
			
			conn = (DBConnection.getInstance()).getConnection();
			pstmt = conn.prepareStatement(s_SQL_UPDATE_ORDER);	
			
			pstmt.setString(1, order.getStatus());
			pstmt.setString(2, order.getErrorCode());
			pstmt.setString(3, order.getErrorMessage());
			pstmt.setInt(4, order.getOrderId());
			
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
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			System.out.println("OrderDB::updatePayment:START");
			
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
		}
	}	
	
	/**
	 * getOrder - Lookup all orders of wood product for customer by orderId
	 * @param orderId - Order Id to search Order
	 * @return Order - Order
	 * @throws ServiceException
	 */
	public static Order getOrder(int orderId)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("OrderDB::getOrderWoodProducts:START");
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
				customer.setPassword(rs.getString(index++));
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
		}
	}			
	
	//Main method to test this class

	public static void main(String[] args) throws Exception
	{
		Customer customer = new Customer();
		
		customer.setFirstName("PHI");
		customer.setLastName("NGUYEN");
		customer.setEmail("phi@gmail.com");
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
		
		WoodProduct wp = new WoodProduct();
		wp.setProductId(1);
		OrderWoodProduct[] owp = new OrderWoodProduct[1];
		owp[0] = new OrderWoodProduct(order, wp, 2, new java.util.Date());
		
		OrderDB db = new OrderDB();
		int orderId = db.createOrder(owp);
	
		System.out.println("OrderId: "+ orderId);
		
	}
}
