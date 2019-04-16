<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.Shipper"%>
<%@ page import="com.ebiz.data.Customer"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.ShipperDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>

<%
<%
String message = (String)session.getAttribute("ERROR");
WoodCategory[] categories = new WoodCategory[1];
Payment payment = new Payment();
try {
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();
	if (request.getParameter("hdnSubmit") != null) {
		OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
		//gather all field data
		Customer customer = getAllParameters(request);
		orderProducts[0].getOrder().setCustomer(customer);
		orderProducts[0].getOrder().setComments(request.getParameter("taComments"));
		session.setAttribute(Constants.s_CUSTOMER_ORDER_CART, orderProducts);
		//Make sure required fields are populated
		String error = validate(customer);
		if(error.length()>0) throw new Exception(error);
	}
	if( session.getAttribute(Constants.s_CUSTOMER_ORDER_CART) != null )
	{
		OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
		payment = orderProducts[0].getOrder().getPayment();
	}
	session.removeAttribute("ERROR");
} catch (Exception ex) {
	session.setAttribute("ERROR", ex.getMessage());
	//message = ex.getMessage();
	response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"createAccount.jsp");
} finally {
}

//add counter for page usages
try{
	Tracker t;
	if( orderProducts != null & orderProducts.length > 0 ){
		for( int i=0; i<orderProducts.length; i++ ){
			t = new Tracker();
			t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
			t.setPage("cartSummary");
			t.setCategoryId(orderProducts[i].getWoodProduct().getCategory().getId());
			t.setProductId(orderProducts[i].getWoodProduct().getProductId());
			t.setClientId(request.getRemoteAddr());
			TrackerDataProvider.getInstance().addTracker(t);
		}
	}else{		
		t = new Tracker();
		t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
		t.setPage(this.getServletName());
		t.setClientId(request.getRemoteAddr());
		TrackerDataProvider.getInstance().addTracker(t);
	}
}
catch(Exception ignore){}
	
%>

<%!private Customer getAllParameters(HttpServletRequest request) {
		Customer customer = new Customer();

		customer.setFirstName((String) request.getParameter("txtFName"));
		customer.setLastName((String) request.getParameter("txtLName"));
		customer.setEmail((String) request.getParameter("txtEmail"));
		customer.setContactPhone((String) request.getParameter("txtPhone"));
		customer.setContactFax((String) request.getParameter("txtFax"));
		customer.setPassword((String) request.getParameter("txtPassword"));
		customer.setAddress1((String) request.getParameter("txtAddress1"));
		customer.setAddress2((String) request.getParameter("txtAddress2"));
		customer.setCity((String) request.getParameter("txtCity"));
		customer.setState((String) request.getParameter("slState"));
		customer.setZip((String) request.getParameter("txtZip"));
		customer.setCountry("US");
		customer.setShipAddress1((String) request
				.getParameter("txtShipAddress1"));
		customer.setShipAddress2((String) request
				.getParameter("txtShipAddress2"));
		customer.setShipCity((String) request.getParameter("txtShipCity"));
		customer.setShipState((String) request.getParameter("slShipState"));
		customer.setShipZip((String) request.getParameter("txtShipZip"));
		customer.setShipCountry("US");

		return customer;
	}

	private String validate(Customer customer) throws Exception {
		if (customer.getFirstName().length() == 0)
			return "First Name is required.";
		if (customer.getLastName().length() == 0)
			return "Last Name is required.";
		if (customer.getEmail().length() == 0)
			return "Email address is required.";
		if (customer.getEmail().indexOf("@") <= 0)
			return "Email address is not valid.";
		if (customer.getAddress1().length() == 0)
			return "Billing Address is required.";
		if (customer.getCity().length() == 0)
			return "Billing City is required.";
		if (customer.getState().length() == 0)
			return "Billing State is required.";
		if (customer.getZip().length() == 0)
			return "Billing Postal Code is required.";
		if (customer.getShipAddress1().length() == 0)
			return "Shipping Address is required.";
		if (customer.getShipCity().length() == 0)
			return "Shipping City is required.";
		if (customer.getShipState().length() == 0)
			return "Shipping State is required.";
		if (customer.getShipZip().length() == 0)
			return "Shipping Postal Code is required.";
		if (customer.getContactPhone().length() == 0)
			return "Contact Phone Number is required.";
		if (customer.getPassword().length() == 0)
			return "Account password is required.";

		return "";
	}%>


<script language="JavaScript" type="text/javascript" src="include/wood.js"></script>

<head>
<title>Wood Crafts</title>
<LINK href=../include/app.css type="text/css" rel="stylesheet">
<LINK href=../include/masthead.css type="text/css" rel="stylesheet">
<LINK href=../include/panels.css type="text/css" rel="stylesheet">
<LINK href=../include/buttons.css type="text/css" rel="stylesheet">
<LINK href=../include/containers.css type="text/css" rel="stylesheet">
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="content-language" content="en-us" />
</head>




<body>

<center>
<table cellspacing="0" cellpadding="0" width="100%">
	<tbody>
		<tr>
			<td width="348" style="PADDING-BOTTOM: 10px">&nbsp;</td>
			<td align=left><a title="Return Home" href="/"><img alt="logo" src="../images/logo.jpg" /></a></td>
		</tr>
		<tr>
			<td align=center colspan=2><br><br>
			<table cellspacing="0" cellpadding="0" width="500" align=center>
			  <tr>
				<td background="../images/menubg.jpg" align=center>		
				 	<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif"" title="Return Home" href="<%=Constants.s_PAGE_ROOT_WOOD%>"><font COLOR="white">&nbsp;&nbsp;&nbsp;Home&nbsp;&nbsp;&nbsp;</font></a>
				</td>
				<td background="../images/menubg.jpg" align=center>				
			 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif"" title="My Account" href="Logon.jsp"><font COLOR="white">My Account</font></a>
			 	</td>
				<td background="../images/menubg.jpg" align=center>
			 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif"" title="View Cart and Checkout" href="cartSummary.jsp"><font COLOR="white">View Cart/Checkout</font></a>
				</td>
				<td background="../images/menubg.jpg" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif"" title="Contact Us" href="contactUs.jsp"><font COLOR="white">Contact Us</font></a>
				</td>
				<td><h5>&nbsp;</h5></td>
		      </tr>
			</table>					
		
			</td>
		</tr>
	</tbody>
</table>
</center>

<form name="frm" method="post" action="paymentMethod.jsp" id="mainForm">
<center>
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0" width="1024"
style="background-image:url(/ebiz/wood/images/pageBackground3.jpg); PADDING-BOTTOM: 200px; background-repeat: no-repeat; PADDING-LEFT: 0px;">
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
		<td width=10>&nbsp;</td>
		<td id="ctl00_centerColumn" style="vertical-align: top; "><br>
		<br>
		<td colspan="2" align=left>	
		<h1 class="leftMenuTitleFont">Delivery Information</h1>
		<table id="ctl00_pageContent_ctl00_productList" class="product-list"
			cellspacing="0" border="0"
			style="width: 100%; border-collapse: collapse;">
			<tr>
				<td width="33%" class="containerBody" style="width: 33.33333%;">
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2" align=left>
							<% if( message != null ){ %>
								<h4><i><font color=red><%=message%></font></i></h4>
							<% } %>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="main" align="left"><b>Shipping Address</b></td>
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
												<td colspan=2>123 Main st</td>
											</tr>
											<tr>
												<td colspan=2>Line 2</td>
											</tr>
											<tr>
												<td colspan=2>City, State Zip</td>
											</tr>
											<tr>
												<td colspan=2>Country</td>
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
						<td colspan="2" class="main" align="left"><b>Please select the preferred shippping method to use on this order</b></td>
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
												<td><input type="radio" name="rdShipper" class="txtinput" /></td>
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
		</table>
		
		<% if( message == null ){  %>	
		<center><br><br>
		<table cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td><b>
						<a id="btnCheckout" href="paymentMethod.jsp" class="buttontextp">CONTINUE TO CHECKOUT</a> 
						&nbsp;| &nbsp; 
						<a id="btnCancel" href="javascript: cancelOrder()" class="buttontextp">CANCEL</a>
					</b>		
				</td>
			</tr>
		</table>
		</center>
		<% } %>
				
		</td>
		<td width=20>&nbsp;</td>
	</tr>
</table>
<br><br>

<br><br><br><br>

<input type="hidden" name="hdnCancelOrder" value="">
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
