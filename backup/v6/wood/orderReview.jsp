<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="ctl00_headTag">
<title>Wood Crafts</title>
<LINK href=../include/app.css type="text/css" rel="stylesheet">
<LINK href=../include/masthead.css type="text/css" rel="stylesheet">
<LINK href=../include/panels.css type="text/css" rel="stylesheet">
<LINK href=../include/buttons.css type="text/css" rel="stylesheet">
<LINK href=../include/containers.css type="text/css" rel="stylesheet">
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="content-language" content="en-us" />
</head>

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.Order"%>
<%@ page import="com.ebiz.data.Shipping"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.StatusCodeDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="com.ebiz.db.ShipDB"%>
<%@ page import="java.util.HashMap"%>


<%
	String message = null;
	WoodCategory[] categories = new WoodCategory[1];
	Order order = new Order();
	OrderWoodProduct[] orderProducts = null;
	Shipping ship = null;
	String confirmationNo = "";
	try {
		categories = WoodCategoryDataProvider.getInstance().getAllCategories();
		confirmationNo = request.getParameter("txtSearch");
		if(confirmationNo == null || confirmationNo.trim().length() == 0 || confirmationNo.indexOf("*") < 0 )
			throw new Exception("Order ID/Confirmation Number is not valid");

		//NOTE: Confirmation has digit and letters separated by *.  We only have digits in our DB.  
		//		Letter is just dummy to give customer without any meaning in the system
		int orderId = Integer.parseInt(confirmationNo.trim().substring(0,confirmationNo.indexOf("*")));

		orderProducts = WoodDB.getOrderWoodProducts(orderId);
		//Get shipping information if oder is shipped
		if( Constants.s_ORDER_SHIPPED_CODE.equals(orderProducts[0].getOrder().getStatus()) )
			ship = ShipDB.getShipping(orderProducts[0].getOrder().getOrderId());
		order = orderProducts[0].getOrder();	
		session.setAttribute(Constants.s_CUSTOMER_REVIEW_CART, orderProducts);
	} catch (Exception ex) {
		session.setAttribute("ERROR", ex.getMessage());
		message = ex.getMessage();
	} finally {
	}
	
	//add counter for page usages
	try{
		Tracker t = new Tracker();
		t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
		t.setPage("orderReview");
		t.setClientId(request.getRemoteAddr());
		TrackerDataProvider.getInstance().addTracker(t);
	}
	catch(Exception ignore){}
	
%>


<body>
<center>
<table cellspacing="0" cellpadding="0" width="100%">
	<tbody>
		<tr>
			<td width="348" style="PADDING-BOTTOM: 10px">&nbsp;</td>
			<td align=left><a title="Return Home" href="/"><img alt="logo" src="../images/logo.jpg" /></a></td>
		</tr>
	</tbody>
</table>
</center>


<form name="frm" method="post" action="processWoodOrderServlet" id="mainForm">
<center>
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0" width="1024"
	style="background-image:url(/ebiz/wood/images/pageBackground.jpg); PADDING-BOTTOM: 30px; background-repeat: no-repeat; PADDING-LEFT: 0px; border-collapse: collapse; ">
	<tr>
		<td colspan=6>
			<table cellspacing="0" cellpadding="0" width="100%" align=center>
					<tr>
						<td align=center colspan=2><br><br>
						<table cellspacing="0" cellpadding="0" width="500" align=center>
						  <tr>
							<td background="../images/menubg.jpg" align=center>		
							 	<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Return Home" href="<%=Constants.s_PAGE_ROOT_WOOD%>"><font COLOR="white">&nbsp;&nbsp;&nbsp;Home&nbsp;&nbsp;&nbsp;</font></a>
							</td>
							<td background="../images/menubg.jpg" align=center>				
						 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="My Account" href="Logon.jsp"><font COLOR="white">My Account</font></a>
						 	</td>
							<td background="../images/menubg.jpg" align=center>
						 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="View Cart and Checkout" href="cartSummary.jsp"><font COLOR="white">View Cart/Checkout</font></a>
							</td>
							<td background="../images/menubg.jpg" align=center>
								<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Contact Us" href="contactUs.jsp"><font COLOR="white">Contact Us</font></a>
							</td>
							<td><h5>&nbsp;</h5></td>
					      </tr>
						</table>					
						</td>
					</tr>
			</table>		
		</td>
	</tr>	
	<tr>
		<td width=20>&nbsp;</td>
		<td width="200" id="ctl00_leftColumn" valign="top"><br>
		<br>
		<br>
		<table border="0" cellpadding="0" cellspacing="0"
			style="background-image: url(images/sidemenubg.jpg); PADDING-BOTTOM: 100px; vertical-align: top; PADDING-LEFT: 0px; PADDING-RIGHT: 10px; PADDING-TOP: 0px">
			<tr>
				<td align=left><br>
				<br>
				<br> <!--<img src="images/shop.jpg" alt="Browse Categories" />-->
				<center>
				<h1 class="leftMenuTitleFont">Shop</h1>
				</center>
				<br>
				<br>
				<ul>
					<% for(int i=0; i<categories.length; i++ ) { %>
					<li><a href="index.jsp?cat=<%=categories[i].getId()%>" class="leftMenuFont">
							<%=categories[i].getName()%></a></li>
					<br>
					<%} %>
				</ul>
				</td>
			</tr>
		</table>
		</td>
		<br>
		<br>
		<td width=50>&nbsp;</td>
		<td width="800" id="ctl00_centerColumn" style="vertical-align: top; " valign="top">
		<br><br>
		
<% if( message != null ){ %>
	<h4><i><font color=red><%=message%></font></i></h4>
<% }else{ %>
		<h1 class="leftMenuTitleFont">My Order</h1>
		<br />
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			border="0" style="width: 100%; border-collapse: collapse;">
			<tr>
				<td>
					<table border="0" width="100%" cellspacing="0" cellpadding="0" align=center>
						<tr>
							<td><b>Your order confirmation number: <i><%=confirmationNo%></i></b><br></td>
						</tr>
						<tr>
							<td><b>Your order status: <i><%=StatusCodeDataProvider.getInstance().getStatus(order.getStatus()).getDescription()%></i></b></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="containerBody" width="33%" style="width: 33.33333%;">
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2">
						<table border="0" width="100%" cellspacing="0" cellpadding="2">
							<tr>
								<td class="main" align="left"><b>Your New Account</b></td>
								<td align="right">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left">
						<table width="100%" border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td class="containerBody">
								<table border="0" width="100%" cellspacing="1" cellpadding="2"
									class="infoBox">
									<tr>
										<td>
										<table border="0" cellspacing="2" cellpadding="1">
											<tr>
												<td align=left>
												<table width="100%" border="0" cellpadding="1"
													cellspacing="1">
													<tr>
														<td width="130" align="left">First Name:</td>
														<td><%=order.getCustomer().getFirstName()==null? "" : order.getCustomer().getFirstName()%></td>
													</tr>
													<tr>
														<td align="left">Last Name:</td>
														<td><%=order.getCustomer().getLastName()==null? "" : order.getCustomer().getLastName()%></td>
													</tr>

													<tr>
														<td align="left">E-Mail:</td>
														<td><%=order.getCustomer().getEmail()==null? "" : order.getCustomer().getEmail()%></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="main" colspan="2" align="left"><b>Your Billing
						Address</b></td>
					</tr>
					<tr>
						<td colspan="2" align="left">
						<table width="100%" border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td class="containerBody">
								<table border="0" width="100%" cellspacing="1" cellpadding="2"
									class="infoBox">
									<tr>
										<td>
										<table border="0" cellpadding="1" cellspacing="2">
											<tr>
												<td width="130">Address Line 1:</td>
												<td><%=order.getCustomer().getAddress1()==null? "" : order.getCustomer().getAddress1()%></td>
											</tr>
											<tr>
												<td>Address Line 2:</td>
												<td><%=order.getCustomer().getAddress2()==null? "" : order.getCustomer().getAddress2()%></td>
											</tr>
											<tr>
												<td>City:</td>
												<td><%=order.getCustomer().getCity()==null? "" : order.getCustomer().getCity()%></td>
											</tr>
											<tr>
												<td>State/Province:</td>
												<td><%=order.getCustomer().getState()==null? "" : order.getCustomer().getState()%></td>
											</tr>
											<tr>
												<td width="130">Post Code:</td>
												<td><%=order.getCustomer().getZip()==null? "" : order.getCustomer().getZip()%></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="main" align="left"><b>Your
						Shipping Address</b></td>
					</tr>
					<tr>
						<td colspan="2" align="left">
						<table width="100%" border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td class="containerBody">
								<table border="0" width="100%" cellspacing="1" cellpadding="2"
									class="infoBox">
									<tr>
										<td>
										<table border="0" cellpadding="1" cellspacing="2">
											<tr>
												<td width="130">Address Line 1:</td>
												<td><%=order.getCustomer().getShipAddress1()==null? "" : order.getCustomer().getShipAddress1()%></td>
											</tr>
											<tr>

												<td>Address Line 2:</td>
												<td><%=order.getCustomer().getShipAddress2()==null? "" : order.getCustomer().getShipAddress2()%></td>
											</tr>
											<tr>
												<td>City:</td>
												<td><%=order.getCustomer().getCity()==null? "" : order.getCustomer().getCity()%></td>
											</tr>
											<tr>
												<td>State/Province:</td>
												<td><%=order.getCustomer().getState()==null? "" : order.getCustomer().getState()%></td>
											</tr>
											<tr>
												<td width="130">Post Code:</td>
												<td><%=order.getCustomer().getZip()==null? "" : order.getCustomer().getZip()%></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="main" align="left"><b>Your Contact
						Information</b></td>
					</tr>
					<tr>
						<td colspan="2" align="left">
						<table width="100%" border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td class="containerBody">
								<table border="0" width="100%" cellspacing="1" cellpadding="2">
									<tr>
										<td>
										<table border="0" cellpadding="1" cellspacing="2">
											<tr>
												<td width="130">Tel Number:</td>
												<td><%=order.getCustomer().getContactPhone()==null? "" : order.getCustomer().getContactPhone()%></td>
											</tr>
											<tr>
												<td>Fax Number:</td>
												<td><%=order.getCustomer().getContactFax()==null? "" : order.getCustomer().getContactFax()%></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="main" align="left"><b>Your Payment
						Information</b></td>
					</tr>
					<tr>
						<td colspan="2" align="left">
						<table width="100%" border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td class="containerBody">
								<table border="0" width="100%" cellspacing="1" cellpadding="2">
									<tr>
										<td>
										<table border="0" cellpadding="1" cellspacing="2">
											<tr>
												<td width="150">Total Charges:</td>
												<td>$<%=order.getPayment().getAmount()%></td>
											</tr>
											<tr>
												<td width="130">Card Owner:</td>
												<td><%=order.getPayment().getCardHolderName()==null? "" : order.getPayment().getCardHolderName()%></td>
											</tr>
											<tr>
												<td>Card Type:</td>
												<td><%=order.getPayment().getCardType()==null? "" : order.getPayment().getCardType()%></td>
											</tr>
											<tr>
												<td>Card Number:</td>
												<td><%=order.getPayment().getMaskedCardNumber()==null? "" : order.getPayment().getMaskedCardNumber()%></td>
											</tr>
											<tr>
												<td>Card Expiration Date:</td>
												<td><%=order.getPayment().getCardExpDateString()==null? "" : order.getPayment().getCardExpDateString()%></td>
											</tr>
											<tr>
												<td>Card Security Code (CVV):</td>
												<td><%=order.getPayment().getMaskedCardCVV()==null? "" : order.getPayment().getMaskedCardCVV()%></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="main" align="left"><b>Your Ordered Products</b></td>
					</tr>
					<tr>
						<td colspan="2" align="left">
						<table width="100%" border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td class="containerBody">
								<table border="0" width="100%" cellspacing="1" cellpadding="2">
									<tr>
										<td>
										<table border="1" cellpadding="1" cellspacing="2">
											<tr align=center>
												<th width="200">Ordered Date</th>
												<th width=60%>Product</th>
												<th width="150">Quantity</th>
												<th width="150">Cost</th>
											</tr>
											<% 
											
												for(int i=0; i<orderProducts.length; i++ ){ 
													java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("MM/dd/yyyy");
											%>											
											<tr>
												<td align=center><%=fm.format(orderProducts[i].getCreateDate())%></td>
												<td>
													<img alt="<%=orderProducts[i].getWoodProduct().getName()%>" src="<%=orderProducts[i].getWoodProduct().getCategory().getUrlPath()+"s"+orderProducts[i].getWoodProduct().getImageName()%>"/>
													&nbsp;<%=orderProducts[i].getWoodProduct().getName()%>
												</td>
												<td align=right><%=orderProducts[i].getQuantity()%></td>
												<td align=right><%=orderProducts[i].getWoodProduct().getPrice()%></td>
											</tr>
											<% } %>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
						
				<% if( ship != null ){ %>			
					<tr>
						<td colspan="2" class="main" align="left"><b>Your Shipping Information</b></td>
					</tr>
					<tr>
						<td colspan="2" align="left">
						<table width="100%" border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td class="containerBody">
								<table border="0" width="100%" cellspacing="1" cellpadding="2">
									<tr>
										<td>
										<table border="0" cellpadding="1" cellspacing="2">
											<tr>
												<td width="130">Shipping Company:</td>
												<td><%=ship.getVendor()==null? "" : ship.getVendor()%></td>
											</tr>
											<tr>
												<td>Tracking Id:</td>
												<td><%=ship.getTrackingId()==null? "" : ship.getTrackingId()%></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>	
				<% } //closing shipping null check %>									
				</table>
				</td>
			</tr>
			</td>
			</tr>
		</table>
		</td>	  
<% } /*close error message check*/ %>		
		<td width=20>&nbsp;</td>
	</tr>
</table>
</center>
</form>
<br><br><br>
<center>
<table cellspacing="0" cellpadding="0">
	<tbody>
		<tr>
			<td><a href="/">Home</a> 
			| <a href="Logon.jsp">My Account</a> 
			| <a href="shippingPolicy.jsp">Shipping Policy</a> 
			| <a href="returnPolicy.jsp">Return Policy</a> 
			| <a href="privacyPolicy.jsp">Privacy Policy</a>  
			| <a href="contactUs.jsp">Contact Us</a> 
			</td>
		</tr>
		<tr>
			<td class="containerFooter" align="center">© 2009 www.eBiz.com
			</td>
		</tr>
	</tbody>
</table>
</center>

</body>
</html>
