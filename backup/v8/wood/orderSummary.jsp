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
<%@ page import="com.ebiz.data.Customer"%>
<%@ page import="com.ebiz.data.Payment"%>
<%@ page import="com.ebiz.data.Shipper"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.ShipperDataProvider"%>
<%@ page import="com.ebiz.cache.StateDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="java.util.HashMap"%>


<%
	String message = "";
	WoodCategory[] categories = new WoodCategory[1];
	Customer customer = new Customer();
	Payment payment = new Payment();
	Shipper shipper = null;
	double orderChargeAmount = 0d;
	double taxes = 0d;
	
	try {
		categories = WoodCategoryDataProvider.getInstance().getAllCategories();		
		if (request.getParameter("hdnSubmit") != null) {
			OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
			customer = orderProducts[0].getOrder().getCustomer();
			//gather all field data
			payment = getAllParameters(request);
			
			//Shipping cost
			String sVendor = String.valueOf(orderProducts[0].getOrder().getShipping().getVendor().getId());
			shipper = ShipperDataProvider.getInstance().getShipper(sVendor);
			orderChargeAmount = orderProducts[0].getOrder().getAmount();
			
			//Calculate tax amount from total charges * tax rate for that state;
			taxes = orderChargeAmount * (StateDataProvider.getInstance().getState(customer.getState(),customer.getCountry()).getTaxRate())/100;			
			
			payment.setAmount(orderChargeAmount + shipper.getCost() + taxes);
			orderProducts[0].getOrder().setPayment(payment);
			session.setAttribute(Constants.s_CUSTOMER_ORDER_CART, orderProducts);

			//validate required fields
			String error = validate(payment);
			if(error.length()>0) throw new Exception(error);			
		}		
		
	} catch (NullPointerException ex) {
		response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"error.jsp");
	} catch (Exception ex) {
		session.setAttribute("ERROR", ex.getMessage());
		response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"paymentMethod.jsp");
		//message = ex.getMessage();
	} finally {
	}
	
	//add counter for page usages
	try{
		Tracker t = new Tracker();
		t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
		t.setPage("orderSummary");
		t.setClientId(request.getRemoteAddr());
		TrackerDataProvider.getInstance().addTracker(t);
	}
	catch(Exception ignore){}
	
%>


<%!private Payment getAllParameters(HttpServletRequest request) {
		Payment payment = new Payment();
		
		//if( "paypal".equals(request.getParameter("rdPaymentType")) ){
			
			payment.setCardHolderName((request.getParameter("txtPayPalCardOwner")).trim());
			payment.setCardType(request.getParameter("slPayPalCardtype"));
			payment.setCardNumber((request.getParameter("txtPayPalCardNo")).trim());
			payment.setCardExpDate(request.getParameter("slPayPalCardExpMonth"),request.getParameter("slPayPalCardExpYear"));
			payment.setCardCVV((request.getParameter("txtPayPalCardCVV")).trim());
		
			/*
		}else if ( "paypal".equals(request.getParameter("rdPaymentType")) ){

			payment.setCardHolderName((request.getParameter("txtCardOwner")).trim());
			payment.setCardType(request.getParameter("slCardtype"));
			payment.setCardNumber((request.getParameter("txtCardNo")).trim());
			payment.setCardExpDate(request.getParameter("slCardExpMonth"),request.getParameter("slPayPalCardExpYear"));
			payment.setCardCVV((request.getParameter("txtCardCVV")).trim());
			
		}
		*/

		return payment;
	}

	private String validate(Payment payment) throws Exception {
		if (payment.getCardHolderName().length() == 0)
			return "Credit Card Holder Name is required.";
		if (payment.getCardNumber().length() == 0)
			return "Credit Card Number is required.";
		if (payment.getCardNumber().length() < 16)
			return "Credit Card Number is invalid.";
		if (payment.getCardCVV().length() == 0)
			return "Credit Card CVV is required.";
		if (payment.getCardCVV().length() < 3)
			return "Credit Card CVV is invalid.";
		if( (new java.util.Date()).after(payment.getCardExpDate()) )
			return "Credit Card Expiration Date is in the past";
				
		return "";
	}
	
%>


<script language="JavaScript" type="text/javascript" src="include/wood.js"></script>

<body>
<form name="frm" method="post" action="orderSubmit.jsp" id="mainForm">
<center>
<table cellspacing="0" cellpadding="0" width="1024">
<tr>
	<td width=5%></td>
 	<td width=20 align=left><img src="images/idealGift2.jpg"></td>
 	<td width=500>
	<table cellspacing="0" cellpadding="0" width="100%" align=center>
		<tr>
			<td align=center colspan=2><br>
			<table cellspacing="0" cellpadding="0" width="500" align=center>
			  <tr>
				<td width=73 background="../images/menubg2.jpg" align=center>		
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Return Home" href="<%=Constants.s_PAGE_ROOT_WOOD%>"><font COLOR="blue">&nbsp;&nbsp;Home&nbsp;&nbsp;</font></a>
				</td>
				<td width=1></td>
				<td width=108 background="../images/menubg3.jpg" align=center>				
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="My Account" href="Logon.jsp"><font COLOR="blue">My Account</font></a>
				</td>
				<td width=1></td>
				<td width=186 background="../images/menubg4_f.jpg" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="View Cart and Checkout" href="cartSummary.jsp"><font COLOR="white">View Cart/Checkout</font></a>
				</td>
				<td width=1></td>
				<td width=108 background="../images/menubg3.jpg" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Contact Us" href="contactUs.jsp"><font COLOR="blue">&nbsp;Contact Us</font></a>
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
	style="background-image:url(/ebiz/wood/images/pageBackground.jpg); PADDING-BOTTOM: 30px; background-repeat: no-repeat; PADDING-LEFT: 0px; border-collapse: collapse; ">
	<tr>
		<td width=20>&nbsp;</td>
		<td width="200" id="ctl00_leftColumn" valign="top"><br>
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
		<td width=50>&nbsp;</td>
		<td width="800" id="ctl00_centerColumn" style="vertical-align: top; ">
		<br><br>
		<h1 class="leftMenuTitleFont">My Order Summary</h1>
		<br />
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			border="0" style="width: 100%; border-collapse: collapse;">
			<tr>
				<td class="containerBody" width="33%" style="width: 33.33333%;">
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2">
						<table border="0" width="100%" cellspacing="0" cellpadding="2">
							<tr>
								<td class="main" align="left"><b>New customer create
								your account</b></td>
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
														<td><%=customer.getFirstName()==null? "" : customer.getFirstName()%></td>
													</tr>
													<tr>
														<td align="left">Last Name:</td>
														<td><%=customer.getLastName()==null? "" : customer.getLastName()%></td>
													</tr>

													<tr>
														<td align="left">E-Mail:</td>
														<td><%=customer.getEmail()==null? "" : customer.getEmail()%></td>
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
												<td><%=customer.getAddress1()==null? "" : customer.getAddress1()%></td>
											</tr>
											<tr>
												<td>Address Line 2:</td>
												<td><%=customer.getAddress2()==null? "" : customer.getAddress2()%></td>
											</tr>
											<tr>
												<td>City:</td>
												<td><%=customer.getCity()==null? "" : customer.getCity()%></td>
											</tr>
											<tr>
												<td>State/Province:</td>
												<td><%=customer.getState()==null? "" : customer.getState()%></td>
											</tr>
											<tr>
												<td width="130">Post Code:</td>
												<td><%=customer.getZip()==null? "" : customer.getZip()%></td>
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
												<td><%=customer.getShipAddress1()==null? "" : customer.getShipAddress1()%></td>
											</tr>
											<tr>

												<td>Address Line 2:</td>
												<td><%=customer.getShipAddress2()==null? "" : customer.getShipAddress2()%></td>
											</tr>
											<tr>
												<td>City:</td>
												<td><%=customer.getCity()==null? "" : customer.getCity()%></td>
											</tr>
											<tr>
												<td>State/Province:</td>
												<td><%=customer.getState()==null? "" : customer.getState()%></td>
											</tr>
											<tr>
												<td width="130">Post Code:</td>
												<td><%=customer.getZip()==null? "" : customer.getZip()%></td>
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
												<td><%=customer.getContactPhone()==null? "" : customer.getContactPhone()%></td>
											</tr>
											<tr>
												<td>Fax Number:</td>
												<td><%=customer.getContactFax()==null? "" : customer.getContactFax()%></td>
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
												<td width="130">Company: </td>
												<td align=left><%=shipper.getName()%></td>
											</tr>
											<tr>
												<td>Type: </td>
												<td align=left><%=shipper.getType()%></td>
											</tr>
											<tr>
												<td>Cost: </td>
												<td align=left>$<%=shipper.getCost()%></td>
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
						<td colspan="2" class="main" align="left"><b>Your Summary Charges</b></td>
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
												<td width="130" align=right>Total Products: </td>
												<td width="50" align=right>$<%=orderChargeAmount%></td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td align=right>Shipping: </td>
												<td align=right>$<%=shipper.getCost()%></td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td align=right>Taxes: </td>
												<td align=right>$<%=com.ebiz.utils.Util.formatNumber(taxes, 2)%></td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td>&nbsp;</td>
												<td><hr>&nbsp;</hr></td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td align=right>Total Charges: </td>
												<td align=right>$<%=com.ebiz.utils.Util.formatNumber(payment.getAmount(), 2)%></td>
												<td>&nbsp;</td>
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
												<td>$<%=com.ebiz.utils.Util.formatNumber(payment.getAmount(), 2)%></td>
											</tr>
											<tr>
												<td>Card Owner:</td>
												<td><%=payment.getCardHolderName()==null? "" : payment.getCardHolderName()%></td>
											</tr>
											<tr>
												<td>Card Type:</td>
												<td><%=payment.getCardType()==null? "" : payment.getCardType()%></td>
											</tr>
											<tr>
												<td>Card Number:</td>
												<td><%=payment.getMaskedCardNumber()==null? "" : payment.getMaskedCardNumber()%></td>
											</tr>
											<tr>
												<td>Card Expiration Date:</td>
												<td><%=payment.getCardExpDateString()==null? "" : payment.getCardExpDateString()%></td>
											</tr>
											<tr>
												<td>Card Security Code (CVV):</td>
												<td><%=payment.getMaskedCardCVV()==null? "" : payment.getMaskedCardCVV()%></td>
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
						<td colspan="2" class="main" align="left"><b>Term and Condition</b></td>
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
												<td>I have read the condition of use (<b> 
													<a href="privacyPolicy.jsp" target="_new">Privacy Policy</a> | 
													<a href="shippingPolicy.jsp" target="_new">Shipping Policy</a> |
													<a href="returnPolicy.jsp" target="_new">Return Policy</a> </b>)
												and <b>I agree</b> to them</td>
												<td width="150" align=right><input type=checkbox name=chkTC></td>
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
						<td colspan="2" align="left">
						<table border="0" width="100%" cellspacing="1" cellpadding="2">
							<tr>
								<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2">
									<tr>
										<br>
										<br>
										<td align="left" width=100>
											<a id="btnCheckout" href="javascript: createOrder()" class="buttontextp"><b>ORDER NOW</b></a>
										</td>
										<td align="left">
											<a id="btnCancel" href="javascript: cancelOrder()" class="buttontextp"><b>CANCEL ORDER</b></a>
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
			</td>
			</tr>
		</table>
		<td width=20>&nbsp;</td>
	</tr>
</table>
<input type=hidden name=hdnSubmit value="submit">
<input type="hidden" name="hdnCancelOrder">
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
