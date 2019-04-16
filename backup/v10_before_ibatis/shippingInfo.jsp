<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.Shipper"%>
<%@ page import="com.ebiz.data.Customer"%>
<%@ page import="com.ebiz.data.User"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.db.UserDB"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.ShipperDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>

<%
String message = (String)session.getAttribute("ERROR");
WoodCategory[] categories = new WoodCategory[1];
Customer customer = null;
int shipVendor = -1;
Shipper[] shippers = null;
try {
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();
	shippers = ShipperDataProvider.getInstance().getShippers();
	if (request.getParameter("hdnSubmit") != null) {
		OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
		//gather all field data
		customer = getAllParameters(request);
		//If customer is able to login, it is existing customer and we need to update instead of create
		if( session.getAttribute(Constants.s_LOGGIN) != null ){
			customer.setCustomerId(((User)session.getAttribute(Constants.s_LOGGIN)).getCustomer().getCustomerId());
		}
		orderProducts[0].getOrder().setCustomer(customer);
		orderProducts[0].getOrder().setComments(request.getParameter("taComments"));
		session.setAttribute(Constants.s_CUSTOMER_ORDER_CART, orderProducts);
		//Make sure required fields are populated
		String error = validate(customer, session.getAttribute(Constants.s_LOGGIN));
		if(error.length()>0) throw new Exception(error);
	}

	if( session.getAttribute(Constants.s_CUSTOMER_ORDER_CART) != null )
	{
		OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
		if( orderProducts[0].getOrder().getShipping() != null )
			shipVendor = orderProducts[0].getOrder().getShipping().getVendor().getId();
	}	
	session.removeAttribute("ERROR");
} catch (Exception ex) {
	session.setAttribute("ERROR", ex.getMessage());
	//message = ex.getMessage();
	response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"createAccount.jsp");
} finally {
}

//add counter for page usages
	//add counter for page usages
	try{
		Tracker t = new Tracker();
		t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
		t.setPage("shippingInfo");
		t.setClientId(request.getRemoteAddr());
		TrackerDataProvider.getInstance().addTracker(t);
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

	private String validate(Customer customer, Object user) throws Exception {
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

		try{
			if( user == null ){
				if(UserDB.validateUser(customer.getEmail(),null, false) != null)
					return "Account already existed in the System.  Please login or use different Email address.";
			}
		}catch(Exception ignore){}
		
		return "";
	}%>


<script language="JavaScript" type="text/javascript" src="include/wood.js"></script>

<head>
<title>Ideal Wood Gifts</title>
<LINK href=include/app.css type="text/css" rel="stylesheet">
<LINK href=include/masthead.css type="text/css" rel="stylesheet">
<LINK href=include/panels.css type="text/css" rel="stylesheet">
<LINK href=include/buttons.css type="text/css" rel="stylesheet">
<LINK href=include/containers.css type="text/css" rel="stylesheet">
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="content-language" content="en-us" />
</head>




<body>

<form name="frm" method="post" action="paymentMethod.jsp" id="mainForm">
<center>
<table cellspacing="0" cellpadding="0" width="1024">
<tr>
	<td width=5%></td>
 	<td width=20 align=left><img src="images/logo.gif"></td>
 	<td width=500>
	<table cellspacing="0" cellpadding="0" width="100%" align=center>
		<tr>
			<td align=center colspan=2><br>
			<table cellspacing="0" cellpadding="0" width="500" align=center>
			  <tr>
				<td width=73 background="images/menubg2a.gif" align=center>		
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Return Home" href="<%=Constants.s_PAGE_ROOT_WOOD%>"><font COLOR="white">&nbsp;&nbsp;Home&nbsp;&nbsp;</font></a>
				</td>
				<td width=1></td>
				<td width=108 background="images/menubg3a.gif" align=center>				
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="My Account" href="Logon.jsp"><font COLOR="white">My Account</font></a>
				</td>
				<td width=1></td>
				<td width=186 background="images/menubg4a_f.gif" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="View Cart and Checkout" href="cartSummary.jsp"><font COLOR="black">View Cart/Checkout</font></a>
				</td>
				<td width=1></td>
				<td width=108 background="images/menubg3a.gif" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Contact Us" href="contactUs.jsp"><font COLOR="white">&nbsp;Contact Us</font></a>
				</td>
				<td><h5>&nbsp;</h5></td>
		      </tr>
			</table>					
			</td>
		</tr>
	</table>
    </td>
    <td width=20%></td>
 </tr>
</table>
	
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0" width="1024"
style="background-image:url(images/pageBackground8.jpg); PADDING-BOTTOM: 200px; background-repeat: no-repeat; PADDING-LEFT: 0px;">
	<tr>
		<td width=20>&nbsp;</td>
		<td width="200" id="ctl00_leftColumn" valign="top"><br>
		<table border="0" cellpadding="0" cellspacing="0"
			style="background-image: url(images/sidemenubgxx.jpg); PADDING-BOTTOM: 100px; vertical-align: top; PADDING-LEFT: 0px; PADDING-RIGHT: 10px; PADDING-TOP: 0px">
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
		<td width=10>&nbsp;</td>
		<td id="ctl00_centerColumn" style="vertical-align: top; " valign="top">
		<td colspan="2" align=left>	<br><br>
		<h1 class="leftMenuTitleFont">Delivery Information</h1><br>
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
												<td colspan=2><%=customer.getShipAddress1()%></td>
											</tr>
											<tr>
												<td colspan=2><%=customer.getShipAddress2()%></td>
											</tr>
											<tr>
												<td colspan=2><%=customer.getShipCity()%>, <%=customer.getShipState()%> <%=customer.getShipZip()%></td>
											</tr>
											<tr>
												<td colspan=2><%=customer.getShipCountry()%></td>
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
										<table border="0" cellpadding="1" cellspacing="2" width=100%>
											<tr>
												<td colspan=2 align=center><h3><%=shippers[0].getName()%></h3></td>
												<td>&nbsp;</td>
											</tr>
										<% 	String checked = "";
											for( int i=0; i<shippers.length; i++ ){
												if( i==shippers.length-1 ) checked = "checked";
										%>
											<tr>
												<td width="250"><%=shippers[i].getType()%></td>
												<td width="50" align=right>$<%=shippers[i].getCost()%></td>
												<td><input type="radio" name="rdShipper" value="<%=shippers[i].getId()%>" <%=checked%> class="txtinput" /></td>
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
				</table>
				</td>
			</tr>
		</table>
		
		<% if( message == null ){  %>	
		<center><br><br>
		<table cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td><b>
						<a id="btnCheckout" href="javascript: createShippingSubmit()" class="buttontextp">CONTINUE TO CHECKOUT</a> 
						&nbsp;| &nbsp; 
						<a id="btnCancel" href="javascript: cancelOrder()" class="buttontextp">CANCEL</a>
					</b>		
				</td>
			</tr>
			
			<tr>
				<td>
				
<%
	/*==================================================================
	 PayPal Express Checkout Call
	 ===================================================================
	*/
%>
<%@include file="paypalfunctions.jsp" %>
<%
if (PaymentOption == "PayPal")
{
	/*
	'------------------------------------
	' The paymentAmount is the total value of 
	' the shopping cart, that was set 
	' earlier in a session variable 
	' by the shopping cart page
	'------------------------------------
	*/

	String paymentAmount = (String)session.getAttribute("Payment_Amount");

	/*
	'------------------------------------
	' The currencyCodeType and paymentType 
	' are set to the selections made on the Integration Assistant 
	'------------------------------------
	*/

	String currencyCodeType = "USD";
	String paymentType = "Sale";

	/*
	'------------------------------------
	' The returnURL is the location where buyers return to when a
	' payment has been succesfully authorized.
	'
	' This is set to the value entered on the Integration Assistant 
	'------------------------------------
	*/

	String returnURL = "https://www.ebizdeal.net/gifts/shippingInfo.jsp";

	/*
	'------------------------------------
	' The cancelURL is the location buyers are sent to when they hit the
	' cancel button during authorization of payment during the PayPal flow
	'
	' This is set to the value entered on the Integration Assistant 
	'------------------------------------
	*/
	String cancelURL = "https://www.ebizdeal.net/gifts";

	/*
	'------------------------------------
	' When you integrate this code 
	' set the variables below with 
	' shipping address details 
	' entered by the user on the 
	' Shipping page.
	'------------------------------------
	*/

	String shipToName 			= "<<ShiptoName>>";
	String shipToStreet 		= "<<ShipToStreet>>";
	String shipToStreet2 		= "<<ShipToStreet2>>"; //'Leave it blank if there is no value
	String shipToCity 			= "<<ShipToCity>>";
	String shipToState 			= "<<ShipToState>>";
	String shipToCountryCode 	= "<<ShipToCountryCode>>"; //' Please refer to the PayPal country codes in the API documentation
	String shipToZip 			= "<<ShipToZip>>";
	String phoneNum 			= "<<PhoneNumber>>";

	/*
	'------------------------------------
	' Calls the SetExpressCheckout API call
	'
	' The CallMarkExpressCheckout function is defined in the file PayPalFunctions.asp,
	' it is included at the top of this file.
	'-------------------------------------------------
	*/

	HashMap nvp = CallMarkExpressCheckout (paymentAmount, currencyCodeType, paymentType, returnURL, cancelURL,
									shipToName, shipToStreet, shipToStreet2, shipToCity, shipToState
									shipToCountryCode, shipToZip, phoneNum );
									
	String strAck = nvp.get("ACK").toString();
	if(strAck !=null && !(strAck.equalsIgnoreCase("Success") || strAck.equalsIgnoreCase("SuccessWithWarning")))
	{
		//' Redirect to paypal.com
		ReDirectURL( nvp.get("TOKEN").toString());
	}
	else
	{  
		// Display a user friendly Error on the page using any of the following error information returned by PayPal
		
		String ErrorCode = nvp.get("L_ERRORCODE0").toString();
		String ErrorShortMsg = nvp.get("L_SHORTMESSAGE0").toString();
		String ErrorLongMsg = nvp.get("L_LONGMESSAGE0").toString();
		String ErrorSeverityCode = nvp.get("L_SEVERITYCODE0").toString();
	}
}
else
{
 if (((PaymentOption == "Visa") || (PaymentOption == "MasterCard") || (PaymentOption == "Amex") || (PaymentOption = "Discover"))
			and ( PaymentProcessorSelected == "PayPal Direct Payment"))

	/*		
	'------------------------------------
	' The paymentAmount is the total value of 
	' the shopping cart, that was set 
	' earlier in a session variable 
	' by the shopping cart page
	'------------------------------------
	*/
	String paymentAmount = (String)session.getAttribute("Payment_Amount");

	/*
	'------------------------------------
	' The paymentType that was selected earlier 
	'------------------------------------
	*/
	String paymentType = "Sale";
	
	/*
	' Set these values based on what was selected by the user on the Billing page Html form
	*/
	
	String creditCardType 		= "<<Visa/MasterCard/Amex/Discover>>"; //' Set this to one of the acceptable values (Visa/MasterCard/Amex/Discover) match it to what was selected on your Billing page
	String creditCardNumber 	= "<<CC number>>"; // ' Set this to the string entered as the credit card number on the Billing page
	String expDate 				= "<<Expiry Date>>"; // ' Set this to the credit card expiry date entered on the Billing page
	String cvv2 				= "<<cvv2>>"; // ' Set this to the CVV2 string entered on the Billing page 
	String firstName 			= "<<firstName>>"; // ' Set this to the customer's first name that was entered on the Billing page 
	String lastName 			= "<<lastName>>"; // ' Set this to the customer's last name that was entered on the Billing page 
	String street 				= "<<street>>"; // ' Set this to the customer's street address that was entered on the Billing page 
	String city 				= "<<city>>"; // ' Set this to the customer's city that was entered on the Billing page 
	String state 				= "<<state>>"; // ' Set this to the customer's state that was entered on the Billing page 
	String zip 					= "<<zip>>"; // ' Set this to the zip code of the customer's address that was entered on the Billing page 
	String countryCode 			= "<<PayPal Country Code>>"; // ' Set this to the PayPal code for the Country of the customer's address that was entered on the Billing page 
	String currencyCode 		= "<<PayPal Currency Code>>"; // ' Set this to the PayPal code for the Currency used by the customer 
	
	/*	
	'------------------------------------------------
	' Calls the DoDirectPayment API call
	'
	' The DirectPayment function is defined in PayPalFunctions.jsp 
	' included at the top of this file.
	'-------------------------------------------------
	*/
	nvp = DirectPayment ( paymentType, paymentAmount, creditCardType, creditCardNumber,
							expDate, cvv2, firstName, lastName, street, city, state, zip, 
							countryCode, currencyCode ); 

	String strAck = nvp.get("ACK").toString();
	if(strAck ==null || strAck.equalsIgnoreCase("Success") || strAck.equalsIgnoreCase("SuccessWithWarning") )
	{
		// Display a user friendly Error on the page using any of the following error information returned by PayPal
		String ErrorCode = nvp.get("L_ERRORCODE0").toString();
		String ErrorShortMsg = nvp.get("L_SHORTMESSAGE0").toString();
		String ErrorLongMsg = nvp.get("L_LONGMESSAGE0").toString();
		String ErrorSeverityCode = nvp.get("L_SEVERITYCODE0").toString();
	}
}
%>				
				
				</td>
			</tr>
		</table>
		</center>
		
		
		<% } %>
				
		</td>
		<td width=20>&nbsp;</td>
	</tr>
</table>

<input type="hidden" name="hdnCancelOrder" value="">
<input type=hidden name=hdnSubmit value="submit">
</form>
<br><br><br>
<center>
<table cellspacing="0" cellpadding="0">
	<tbody>
		<tr>
			<td><a href="index.html">Home</a> 
			| <a href="Logon.jsp">My Account</a> 
			| <a href="shippingPolicy.jsp">Shipping Policy</a> 
			| <a href="returnPolicy.jsp">Return Policy</a> 
			| <a href="privacyPolicy.jsp">Privacy Policy</a>  
			| <a href="contactUs.jsp">Contact Us</a> 
			</td>
		</tr>
		<tr>
			<td class="containerFooter" align="center">© 2009 Power by eBizDeal.net</td>
		</tr>
	</tbody>
</table>
</center>
</body>
</html>
