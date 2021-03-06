<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<title>Ideal Wood Gifts</title>
<LINK href=include/app.css type="text/css" rel="stylesheet">
<LINK href=include/masthead.css type="text/css" rel="stylesheet">
<LINK href=include/panels.css type="text/css" rel="stylesheet">
<LINK href=include/buttons.css type="text/css" rel="stylesheet">
<LINK href=include/containers.css type="text/css" rel="stylesheet">
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="content-language" content="en-us" />
</head>

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.Order"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="java.util.HashMap"%>


<%
	String message = "";
	WoodCategory[] categories = new WoodCategory[1];
	Order order = new Order();
	
	try {
		categories = WoodCategoryDataProvider.getInstance().getAllCategories();		
		OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
		order = orderProducts[0].getOrder();	
		//Clear all session attribute to start a new CART!
		CustomerSession.clearSession(session);
	} catch (Exception ex) {
		session.setAttribute("ERROR", ex.getMessage());
		message = ex.getMessage();
	} finally {
	}
	

	//add counter for page usages
	try{
		Tracker t = new Tracker();
		t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
		t.setPage("orderConfirmation");
		t.setClientId(request.getRemoteAddr());
		TrackerDataProvider.getInstance().addTracker(t);
	}
	catch(Exception ignore){}	
	
%>


<body>
<form name="frm" method="post" action="processWoodOrderServlet" id="mainForm">
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
	style="background-image:url(images/pageBackground6.jpg); PADDING-BOTTOM: 30px; background-repeat: no-repeat; PADDING-LEFT: 0px; border-collapse: collapse; ">
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
		<h1 class="leftMenuTitleFont">My Order Confirmation</h1>
		<br />
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			border="0" style="width: 100%; border-collapse: collapse;">
			<tr>
				<td align=center>Please print out this page for your future references.  An email also sent to your email address.
				</td>
			</tr>
			<tr>
				<td align=center><br><h2><b>Your order confirmation number: <i><%=order.getConfirmationNo()%></i></b></h2>
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
												<td>$<%=com.ebiz.utils.Util.formatNumber(order.getPayment().getAmount(), 2)%></td>
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
						<td>
<%
/*==================================================================
 PayPal Express Checkout Call
 ===================================================================
*/
String token = session.getAttribute("token");
if ( token != null)
{
%>
<%@include file="paypalfunctions.jsp" %>
<% 
	/*
	'------------------------------------
	' Get the token parameter value stored in the session 
	' from the previous SetExpressCheckout call
	'------------------------------------
	*/
	String token =  session.getAttribute("TOKEN");

	/*
	'------------------------------------
	' The paymentAmount is the total value of 
	' the shopping cart, that was set 
	' earlier in a session variable 
	' by the shopping cart page
	'------------------------------------
	*/
	
	String finalPaymentAmount =  session.getAttribute("Payment_Amount");
	/*
	'------------------------------------
	' Calls the DoExpressCheckoutPayment API call
	'
	' The ConfirmPayment function is defined in the file PayPalFunctions.jsp,
	' that is included at the top of this file.
	'-------------------------------------------------
	*/

	HashMap nvp = ConfirmPayment ( finalPaymentAmount );
	String strAck = nvp.get("ACK").toString();
	if(strAck !=null && !(strAck.equalsIgnoreCase("Success") || strAck.equalsIgnoreCase("SuccessWithWarning")))
	{
		/*
		'********************************************************************************************************************
		'
		' THE PARTNER SHOULD SAVE THE KEY TRANSACTION RELATED INFORMATION LIKE 
		'                    transactionId & orderTime 
		'  IN THEIR OWN  DATABASE
		' AND THE REST OF THE INFORMATION CAN BE USED TO UNDERSTAND THE STATUS OF THE PAYMENT 
		'
		'********************************************************************************************************************
		*/

		String transactionId	= nvp.get("TRANSACTIONID").toString(); // ' Unique transaction ID of the payment. Note:  If the PaymentAction of the request was Authorization or Order, this value is your AuthorizationID for use with the Authorization & Capture APIs. 
		String transactionType 	= nvp.get("TRANSACTIONTYPE").toString(); //' The type of transaction Possible values: l  cart l  express-checkout 
		String paymentType		= nvp.get("PAYMENTTYPE").toString();  //' Indicates whether the payment is instant or delayed. Possible values: l  none l  echeck l  instant 
		String orderTime 		= nvp.get("ORDERTIME").toString();  //' Time/date stamp of payment
		String amt				= nvp.get("AMT").toString();  //' The final amount charged, including any shipping and taxes from your Merchant Profile.
		String currencyCode		= nvp.get("CURRENCYCODE").toString();  //' A three-character currency code for one of the currencies listed in PayPay-Supported Transactional Currencies. Default: USD. 
		String feeAmt			= nvp.get("FEEAMT").toString();  //' PayPal fee amount charged for the transaction
		String settleAmt		= nvp.get("SETTLEAMT").toString();  //' Amount deposited in your PayPal account after a currency conversion.
		String taxAmt			= nvp.get("TAXAMT").toString();  //' Tax charged on the transaction.
		String exchangeRate		= nvp.get("EXCHANGERATE").toString();  //' Exchange rate if a currency conversion occurred. Relevant only if your are billing in their non-primary currency. If the customer chooses to pay with a currency other than the non-primary currency, the conversion occurs in the customerís account.
		
		/*
		' Status of the payment: 
				'Completed: The payment has been completed, and the funds have been added successfully to your account balance.
				'Pending: The payment is pending. See the PendingReason element for more information. 
		*/
		
		String paymentStatus	= nvp.get("PAYMENTSTATUS").toString(); 

		/*
		'The reason the payment is pending:
		'  none: No pending reason 
		'  address: The payment is pending because your customer did not include a confirmed shipping address and your Payment Receiving Preferences is set such that you want to manually accept or deny each of these payments. To change your preference, go to the Preferences section of your Profile. 
		'  echeck: The payment is pending because it was made by an eCheck that has not yet cleared. 
		'  intl: The payment is pending because you hold a non-U.S. account and do not have a withdrawal mechanism. You must manually accept or deny this payment from your Account Overview. 		
		'  multi-currency: You do not have a balance in the currency sent, and you do not have your Payment Receiving Preferences set to automatically convert and accept this payment. You must manually accept or deny this payment. 
		'  verify: The payment is pending because you are not yet verified. You must verify your account before you can accept this payment. 
		'  other: The payment is pending for a reason other than those listed above. For more information, contact PayPal customer service. 
		*/
		
		String pendingReason	= nvp.get("PENDINGREASON").toString();  

		/*
		'The reason for a reversal if TransactionType is reversal:
		'  none: No reason code 
		'  chargeback: A reversal has occurred on this transaction due to a chargeback by your customer. 
		'  guarantee: A reversal has occurred on this transaction due to your customer triggering a money-back guarantee. 
		'  buyer-complaint: A reversal has occurred on this transaction due to a complaint about the transaction from your customer. 
		'  refund: A reversal has occurred on this transaction because you have given the customer a refund. 
		'  other: A reversal has occurred on this transaction due to a reason not listed above. 
		*/
		
		String reasonCode		= nvp.get("REASONCODE").toString();   
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
		
%>						
						</td>
					
					<tr>
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
