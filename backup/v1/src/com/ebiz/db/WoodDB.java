package com.ebiz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ebiz.data.Customer;
import com.ebiz.data.Order;
import com.ebiz.data.OrderWoodProduct;
import com.ebiz.data.Payment;
import com.ebiz.data.WoodProduct;
import com.ebiz.data.WoodCategory;
import com.ebiz.framework.data.ServiceException;

/**
 * LookupDB is a database operation class.  It's reponsible to query database
 * tables for certain operation.
 *
 */
public class WoodDB {

	static final String s_SQL_QUERY_ALL_WOOD_CATEGORY =
		" SELECT category_id, name, description, url_path, import_tax_rate, margin "
			+ " FROM Wood_Category ORDER BY name ";

	static final String s_SQL_QUERY_ALL_WOOD_PRODUCT = 
		" SELECT 	wc.category_id, wc.name, wc.description, wc.url_path, " + 
		"			wc.import_tax_rate, wc.margin, " +
		" 			wp.product_id, wp.name, wp.description, wp.width, wp.length, " +
		" 			wp.height, wp.base_price, wp.price, wp.for_sale, " +
		"			wp.shipping_cost, wp.image_name, wp.vendor_id, wp.vendor_name, " +
		" 			wp.vendor_desc, wp.vendor_width, wp.vendor_length, " +
		" 			wp.vendor_height, wp.vendor_price, wp.create_date, wp.update_date " +
		" FROM 	Wood_Product wp, Wood_Category wc " +
		" WHERE wp.category_id = wc.category_id " +
		" ORDER BY wc.category_id, wp.product_id ";

	static final String s_SQL_QUERY_WOOD_PRODUCT = 
			" SELECT 	wc.category_id, wc.name, wc.description, wc.url_path, " +
			"			wc.import_tax_rate, wc.margin, " +
			" 			wp.product_id, wp.name, wp.description, wp.width, wp.length, " +
		 	" 			wp.height, wp.base_price, wp.price, wp.for_sale, " +
			"			wp.shipping_cost, wp.image_name, wp.vendor_id, wp.vendor_name, " +
			" 			wp.vendor_desc, wp.vendor_width, wp.vendor_length, " +
			" 			wp.vendor_height, wp.vendor_price, wp.create_date, wp.update_date " +
		    " FROM 	Wood_Product wp, Wood_Category wc " +
			" WHERE wp.category_id = wc.category_id " +
		 	"  AND	wc.category_id = ? " +
			"  AND  wp.for_sale = 'Y' " +
			" ORDER BY wc.category_id, wp.product_id ";

	static final String s_SQL_QUERY_WOOD_PRODUCT_BY_ID = 
		" SELECT 	wc.category_id, wc.name, wc.description, wc.url_path, " +
		"			wc.import_tax_rate, wc.margin, " +
		" 			wp.product_id, wp.name, wp.description, wp.width, wp.length, " +
	 	" 			wp.height, wp.base_price, wp.price, wp.for_sale, " +
		"			wp.shipping_cost, wp.image_name, wp.vendor_id, wp.vendor_name, " +
		" 			wp.vendor_desc, wp.vendor_width, wp.vendor_length, " +
		" 			wp.vendor_height, wp.vendor_price, wp.create_date, wp.update_date " +
	    " FROM 	Wood_Product wp, Wood_Category wc " +
		" WHERE wp.category_id = wc.category_id " +
		"  AND  wp.for_sale = 'Y' "	 +
	 	"  AND	wp.product_id in (";
	
	static final String s_SQL_QUERY_HOT_PRODUCT = 
		" SELECT 	wc.category_id, wc.name, wc.description, wc.url_path, "  +
		"			wc.import_tax_rate, wc.margin, " +
		" 			wp.product_id, wp.name, wp.description, wp.width, wp.length, " +
		" 			wp.height, wp.base_price, wp.price, wp.for_sale, " +
		"			wp.shipping_cost, wp.image_name, wp.vendor_id, wp.vendor_name, " +
		" 			wp.vendor_desc, wp.vendor_width, wp.vendor_length, " +
		" 			wp.vendor_height, wp.vendor_price, wp.create_date, wp.update_date " +
		" FROM 	Wood_Product wp, Wood_Category wc " +
		" WHERE wp.category_id = wc.category_id " +
		"  AND wc.category_id = ? " +
		"  AND  wp.for_sale = 'Y' " +
		"  AND  wp.price <= (select min(price) + 5 from wood_product where category_id = ?)" + 
		"  LIMIT 5";
	
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

	static final String s_SQL_SELECT_ORDER_WOOD_PRODUCT = 
			"   SELECT 	op.quantity, op.create_date, " +
			"           wc.category_id, wc.name, wc.description, wc.url_path, " + 
			"			wc.import_tax_rate, wc.margin, " +
			" 			wp.product_id, wp.name, wp.description, wp.width, wp.length, " +
			" 			wp.height, wp.base_price, wp.price, wp.for_sale, " +
			"			wp.shipping_cost, wp.image_name, wp.vendor_id, wp.vendor_name, " +
			" 			wp.vendor_desc, wp.vendor_width, wp.vendor_length, " +
			" 			wp.vendor_height, wp.vendor_price, wp.create_date, wp.update_date " +			
			"   FROM    Orders_Wood_Product op, Wood_Product wp, Wood_Category wc " + 
			"   WHERE   op.product_id = wp.product_id " +
			"   AND     wp.category_id = wc.category_id " + 
			"   AND     op.order_id = ? "; 
	
	
	/**
	 * getAllCategory - Lookup all wood category
	 * @return WoodCategory[] - Array of Wood Category in the system
	 * @throws ServiceException
	 */
	public static WoodCategory[] getAllCategory()
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("WoodDB::getAllCategory:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_QUERY_ALL_WOOD_CATEGORY);

			rs = pstmt.executeQuery();

			int index = 1;
			ArrayList<WoodCategory> list = new ArrayList<WoodCategory>();
			// Walk thru resultset
			while (rs.next()) {
				list.add(new WoodCategory(
						rs.getInt(index++),
						rs.getString(index++),
						rs.getString(index++),
						rs.getString(index++),
						rs.getDouble(index++),
						rs.getDouble(index++)));
				index = 1;
			}

			WoodCategory[] cats = new WoodCategory[list.size()];
			cats = list.toArray(cats);
			return cats;
			
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
	 * getHotWoodProduct - Lookup all wood category
	 * @return WoodProduct[] - Array of Wood Product in the system
	 * @throws ServiceException
	 */
	public static WoodProduct[] getHotWoodProduct(int[] categories)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("WoodDB::getHotWoodProduct:START");
			conn = (DBConnection.getInstance()).getConnection();

			int index = 1;
			WoodProduct product;
			WoodCategory category;
			ArrayList<WoodProduct> list = new ArrayList<WoodProduct>();
			//Get hot product for each category
			for( int i=0; i<categories.length; i++ )
			{
				pstmt = conn.prepareStatement(s_SQL_QUERY_HOT_PRODUCT);
				pstmt.setInt(1, categories[i]);
				pstmt.setInt(2, categories[i]);
				rs = pstmt.executeQuery();
	
				// Walk thru resultset
				while (rs.next()) {
					product = new WoodProduct();
									
					category = new WoodCategory(
							rs.getInt(index++),
							rs.getString(index++),
							rs.getString(index++),
							rs.getString(index++),
							rs.getDouble(index++),
							rs.getDouble(index++));
					
					product = new WoodProduct();
					product.setCategory(category);
					product.setProductId(rs.getInt(index++));
					product.setName(rs.getString(index++));
					product.setDescription(rs.getString(index++));
					product.setWidth(rs.getDouble(index++));
					product.setLength(rs.getDouble(index++));
					product.setHeight(rs.getDouble(index++));
					product.setBasePrice(rs.getDouble(index++));
					product.setPrice(rs.getDouble(index++));
					product.setForSale("Y".equals(rs.getString(index++)));
					product.setShippingCost(rs.getDouble(index++));
					product.setImageName(rs.getString(index++));
					product.setImageURL(product.getCategory().getUrlPath()+product.getImageName());
					product.setVendorId(rs.getString(index++));
					product.setVendorName(rs.getString(index++));
					product.setVendorDescription(rs.getString(index++));
					product.setVendorWidth(rs.getDouble(index++));
					product.setVendorLenght(rs.getDouble(index++));
					product.setVendorHeight(rs.getDouble(index++));
					product.setVendorPrice(rs.getDouble(index++));
					product.setCreateDate(rs.getTimestamp(index++));
					product.setUpdateDate(rs.getTimestamp(index++));
					
					list.add(product);
					index = 1;
				}
			}
			
			WoodProduct[] products = new WoodProduct[list.size()];
			products = list.toArray(products);
			return products;
			
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
	 * getAllWoodProduct - Lookup all wood category
	 * @return WoodProduct[] - Array of Wood Product in the system
	 * @throws ServiceException
	 */
	public static WoodProduct[] getAllWoodProduct()
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("WoodDB::getAllWoodProduct:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_QUERY_ALL_WOOD_PRODUCT);

			rs = pstmt.executeQuery();

			int index = 1;
			WoodProduct product;
			WoodCategory category;
			ArrayList<WoodProduct> list = new ArrayList<WoodProduct>();
			// Walk thru resultset
			while (rs.next()) {
				product = new WoodProduct();
								
				category = new WoodCategory(
						rs.getInt(index++),
						rs.getString(index++),
						rs.getString(index++),
						rs.getString(index++),
						rs.getDouble(index++),
						rs.getDouble(index++));
				
				product = new WoodProduct();
				product.setCategory(category);
				product.setProductId(rs.getInt(index++));
				product.setName(rs.getString(index++));
				product.setDescription(rs.getString(index++));
				product.setWidth(rs.getDouble(index++));
				product.setLength(rs.getDouble(index++));
				product.setHeight(rs.getDouble(index++));
				product.setBasePrice(rs.getDouble(index++));
				product.setPrice(rs.getDouble(index++));
				product.setForSale("Y".equals(rs.getString(index++)));
				product.setShippingCost(rs.getDouble(index++));
				product.setImageName(rs.getString(index++));
				product.setImageURL(product.getCategory().getUrlPath()+product.getImageName());
				product.setVendorId(rs.getString(index++));
				product.setVendorName(rs.getString(index++));
				product.setVendorDescription(rs.getString(index++));
				product.setVendorWidth(rs.getDouble(index++));
				product.setVendorLenght(rs.getDouble(index++));
				product.setVendorHeight(rs.getDouble(index++));
				product.setVendorPrice(rs.getDouble(index++));
				product.setCreateDate(rs.getTimestamp(index++));
				product.setUpdateDate(rs.getTimestamp(index++));
				
				list.add(product);
				index = 1;
			}

			WoodProduct[] products = new WoodProduct[list.size()];
			products = list.toArray(products);
			return products;
			
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
	 * getWoodProduct - Lookup wood product based on input category
	 * @return WoodProduct[] - Array of Wood Product by category in the system
	 * @throws ServiceException
	 */
	public static WoodProduct[] getWoodProduct(int categoryId)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("WoodDB::getWoodProduct:START");
			conn = (DBConnection.getInstance()).getConnection();

			pstmt = conn.prepareStatement(s_SQL_QUERY_WOOD_PRODUCT);
			pstmt.setInt(1, categoryId);
			
			rs = pstmt.executeQuery();

			int index = 1;
			WoodProduct product;
			WoodCategory category;
			ArrayList<WoodProduct> list = new ArrayList<WoodProduct>();
			// Walk thru resultset
			while (rs.next()) {
				product = new WoodProduct();
								
				category = new WoodCategory(
						rs.getInt(index++),
						rs.getString(index++),
						rs.getString(index++),
						rs.getString(index++),
						rs.getDouble(index++),
						rs.getDouble(index++));
				
				product = new WoodProduct();
				product.setCategory(category);
				product.setProductId(rs.getInt(index++));
				product.setName(rs.getString(index++));
				product.setDescription(rs.getString(index++));
				product.setWidth(rs.getDouble(index++));
				product.setLength(rs.getDouble(index++));
				product.setHeight(rs.getDouble(index++));
				product.setBasePrice(rs.getDouble(index++));
				product.setPrice(rs.getDouble(index++));
				product.setForSale("Y".equals(rs.getString(index++)));
				product.setShippingCost(rs.getDouble(index++));
				product.setImageName(rs.getString(index++));
				product.setImageURL(product.getCategory().getUrlPath()+product.getImageName());
				product.setVendorId(rs.getString(index++));
				product.setVendorName(rs.getString(index++));
				product.setVendorDescription(rs.getString(index++));
				product.setVendorWidth(rs.getDouble(index++));
				product.setVendorLenght(rs.getDouble(index++));
				product.setVendorHeight(rs.getDouble(index++));
				product.setVendorPrice(rs.getDouble(index++));
				product.setCreateDate(rs.getTimestamp(index++));
				product.setUpdateDate(rs.getTimestamp(index++));
				
				list.add(product);
				index = 1;
			}

			WoodProduct[] products = new WoodProduct[list.size()];
			products = list.toArray(products);
			return products;
			
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
	 * getWoodProduct - Lookup wood product based on input category
	 * @return WoodProduct[] - Array of Wood Product by category in the system
	 * @throws ServiceException
	 */
	public static WoodProduct[] getWoodProductByIds(int[] ids)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("WoodDB::getWoodProductByIds:START");
			conn = (DBConnection.getInstance()).getConnection();

			String sqlStr = "";
			for( int i=0; i<ids.length; i++ ){
				sqlStr += ids[i] + ",";
			}
			sqlStr = sqlStr.substring(0, sqlStr.length()-1);
			
			sqlStr = s_SQL_QUERY_WOOD_PRODUCT_BY_ID + sqlStr + " ) ";
			
			pstmt = conn.prepareStatement(sqlStr);
			
			rs = pstmt.executeQuery();

			int index = 1;
			WoodProduct product;
			WoodCategory category;
			ArrayList<WoodProduct> list = new ArrayList<WoodProduct>();
			// Walk thru resultset
			while (rs.next()) {
				product = new WoodProduct();
								
				category = new WoodCategory(
						rs.getInt(index++),
						rs.getString(index++),
						rs.getString(index++),
						rs.getString(index++),
						rs.getDouble(index++),
						rs.getDouble(index++));
				
				product = new WoodProduct();
				product.setCategory(category);
				product.setProductId(rs.getInt(index++));
				product.setName(rs.getString(index++));
				product.setDescription(rs.getString(index++));
				product.setWidth(rs.getDouble(index++));
				product.setLength(rs.getDouble(index++));
				product.setHeight(rs.getDouble(index++));
				product.setBasePrice(rs.getDouble(index++));
				product.setPrice(rs.getDouble(index++));
				product.setForSale("Y".equals(rs.getString(index++)));
				product.setShippingCost(rs.getDouble(index++));
				product.setImageName(rs.getString(index++));
				product.setImageURL(product.getCategory().getUrlPath()+product.getImageName());
				product.setVendorId(rs.getString(index++));
				product.setVendorName(rs.getString(index++));
				product.setVendorDescription(rs.getString(index++));
				product.setVendorWidth(rs.getDouble(index++));
				product.setVendorLenght(rs.getDouble(index++));
				product.setVendorHeight(rs.getDouble(index++));
				product.setVendorPrice(rs.getDouble(index++));
				product.setCreateDate(rs.getTimestamp(index++));
				product.setUpdateDate(rs.getTimestamp(index++));
				
				list.add(product);
				index = 1;
			}

			WoodProduct[] products = new WoodProduct[list.size()];
			products = list.toArray(products);
			return products;
			
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
	 * getOrderWoodProducts - Lookup all orders of wood product for customer by orderId
	 * @param orderId - Order Id to search Order
	 * @return OrderWoodProduct[] - Array of Wood Product has been ordered
	 * @throws ServiceException
	 */
	public static OrderWoodProduct[] getOrderWoodProducts(int orderId)
			throws ServiceException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			System.out.println("WoodDB::getOrderWoodProducts:START");
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
				
				System.out.println("******"+payment.toString());
				
				index = 1;
			}

			pstmt = conn.prepareStatement(s_SQL_SELECT_ORDER_WOOD_PRODUCT);
			pstmt.setInt(1, orderId);
			
			rs = pstmt.executeQuery();

			index = 1;

			WoodProduct wp;
			WoodCategory wc;
			OrderWoodProduct owp;
			ArrayList<OrderWoodProduct> list = new ArrayList<OrderWoodProduct>();
			while(rs.next()){
				owp = new OrderWoodProduct();
				owp.setQuantity(rs.getInt(index++));
				owp.setCreateDate(rs.getTimestamp(index++));
				owp.setOrder(order);
				
				wc = new WoodCategory();
				wc.setId(rs.getInt(index++));
				wc.setName(rs.getString(index++));
				wc.setDescription(rs.getString(index++));
				wc.setUrlPath(rs.getString(index++));
				wc.setImportTaxRate(rs.getDouble(index++));
				wc.setMargin(rs.getDouble(index++));
				
				wp = new WoodProduct();
				wp.setCategory(wc);
				
				wp.setProductId(rs.getInt(index++));
				wp.setName(rs.getString(index++));
				wp.setDescription(rs.getString(index++));
				wp.setWidth(rs.getDouble(index++));
				wp.setLength(rs.getDouble(index++));
				wp.setHeight(rs.getDouble(index++));
				wp.setBasePrice(rs.getDouble(index++));
				wp.setPrice(rs.getDouble(index++));
				wp.setForSale("Y".equals(rs.getString(index++)));
				wp.setShippingCost(rs.getDouble(index++));
				wp.setImageName(rs.getString(index++));
				wp.setImageURL(wp.getCategory().getUrlPath()+wp.getImageName());
				wp.setVendorId(rs.getString(index++));
				wp.setVendorName(rs.getString(index++));
				wp.setVendorDescription(rs.getString(index++));
				wp.setVendorWidth(rs.getDouble(index++));
				wp.setVendorLenght(rs.getDouble(index++));
				wp.setVendorHeight(rs.getDouble(index++));
				wp.setVendorPrice(rs.getDouble(index++));
				wp.setCreateDate(rs.getTimestamp(index++));
				wp.setUpdateDate(rs.getTimestamp(index++));				

				owp.setWoodProduct(wp);
				owp.setOrder(order);
				
				list.add(owp);
				
				index = 1;
			}
			
			OrderWoodProduct[] rets = new OrderWoodProduct[list.size()];
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
		/*
		System.out.println("-------get all wood categories--------------");
		
		WoodCategory[] cats = WoodDB.getAllCategory();
		int[] categories = new int[cats.length];
		for( int i=0; i<cats.length; i++ ){
			System.out.println("["+i+"] cat["+cats[i]+"] name["+cats[i].getName()+"]");
			categories[i] = cats[i].getId();
		}

		System.out.println("-------get all wood products--------------");
		
		WoodProduct[] prods = WoodDB.getAllWoodProduct();
		for( int i=0; i<prods.length; i++ ){
			System.out.println("["+i+"] prods["+prods[i]+"] name["+prods[i].getName()+"]");
		}

		System.out.println("-------get hot wood products--------------");
		
		prods = WoodDB.getHotWoodProduct(categories);
		for( int i=0; i<prods.length; i++ ){
			System.out.println("["+i+"] prods["+prods[i]+"] name["+prods[i].getName()+"]");
		}
	
		System.out.println("-------get all wood products for a category --------------");
		
		prods = WoodDB.getWoodProduct(1);
		for( int i=0; i<prods.length; i++ ){
			System.out.println("["+i+"] prods["+prods[i]+"] name["+prods[i].getName()+"] imageURL["+prods[i].getImageURL()+"]");
		}

		System.out.println("-------get all wood products by Id --------------");		
		
		int[] ids = new int[]{1,3,5};
		prods = WoodDB.getWoodProductByIds(ids);
		for( int i=0; i<prods.length; i++ ){
			System.out.println("["+i+"] prods["+prods[i]+"] name["+prods[i].getName()+"] imageURL["+prods[i].getImageURL()+"]");
		}
		*/
		System.out.println("-------get order by orderId --------------");
		
		OrderWoodProduct[] orders = WoodDB.getOrderWoodProducts(1);
		for( int i=0; i<orders.length; i++ ){
			System.out.println(orders[i].toString());
		}
		
	}
	
	
}
