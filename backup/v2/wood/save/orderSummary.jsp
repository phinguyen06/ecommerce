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
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="java.util.HashMap"%>


<%
	String message = "";
	WoodCategory[] categories = new WoodCategory[1];
	Customer customer = new Customer();
	Payment payment = new Payment();
	
	try {
		categories = WoodCategoryDataProvider.getInstance().getAllCategories();		
		if (request.getParameter("hdnSubmit") != null) {
			OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
			customer = orderProducts[0].getOrder().getCustomer();
			//gather all field data
			payment = getAllParameters(request);
			payment.setAmount(orderProducts[0].getOrder().getPayment().getAmount());
			orderProducts[0].getOrder().setPayment(payment);
			session.setAttribute(Constants.s_CUSTOMER_ORDER_CART, orderProducts);
			//validate required fields
			String error = validate(payment);
			if(error.length()>0) throw new Exception(error);
			//System.out.println("orderSummary.jsp customer:"+orderProducts[0].getOrder().getCustomer()+" COUNTRY:"+customer.getCountry());
		}		
		
	} catch (Exception ex) {
		session.setAttribute("ERROR", ex.getMessage());
		response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"paymentMethod.jsp");
		//message = ex.getMessage();
	} finally {
	}
%>


<%!private Payment getAllParameters(HttpServletRequest request) {
		Payment payment = new Payment();
		
		if( "paypal".equals(request.getParameter("rdPaymentType")) ){
			
			payment.setCardHolderName((request.getParameter("txtPayPalCardOwner")).trim());
			payment.setCardType(request.getParameter("slPayPalCardtype"));
			payment.setCardNumber((request.getParameter("txtPayPalCardNo")).trim());
			payment.setCardExpDate(request.getParameter("slPayPalCardExpMonth"),request.getParameter("slPayPalCardExpYear"));
			payment.setCardCVV((request.getParameter("txtPayPalCardCVV")).trim());
			
		}else if ( "paypal".equals(request.getParameter("rdPaymentType")) ){

			payment.setCardHolderName((request.getParameter("txtCardOwner")).trim());
			payment.setCardType(request.getParameter("slCardtype"));
			payment.setCardNumber((request.getParameter("txtCardNo")).trim());
			payment.setCardExpDate(request.getParameter("slCardExpMonth"),request.getParameter("slPayPalCardExpYear"));
			payment.setCardCVV((request.getParameter("txtCardCVV")).trim());
			
		}

		return payment;
	}

	private String validate(Payment payment) throws Exception {
		if (payment.getCardHolderName().length() == 0)
			return "Credit Card Holder Name is required.";
		if (payment.getCardNumber().length() == 0)
			return "Credit Card Number is required.";
		if (payment.getCardCVV().length() == 0)
			return "Credit Card CVV is required.";
		if( (new java.util.Date()).after(payment.getCardExpDate()) )
			return "Credit Card Expiration Date is in the past";
				
		return "";
	}%>

<script language=javascript>

function cancelOrder()
{  
	if( confirm("Are you sure you want to cancel the order?") )
	{
		document.frm.hdnCancelOrder.value = "CANCELORDER";
		document.frm.action = "index.jsp";
		document.frm.submit();
	}	
}

</script>

<body>
<table cellspacing="0" cellpadding="0" width="100%">
	<tbody>
		<tr>
			<td width="348" style="PADDING-BOTTOM: 10px">&nbsp;</td>
			<td align=left><a title="Return Home" href="/"><img
				alt="logo" src="../images/logo.jpg" /></a></td>
		</tr>
		<tr>
			<td colspan="2"><br>
			<center><a title="Return Home" href="/"> <img
				height="39" alt="Home" src="../images/home.jpg" width="99" /></a> <a
				title="My Account" href="#"> <img height="39" alt="My Account"
				src="../images/myaccount.jpg" width="135" /></a> <a
				title="View Cart and Checkout" href="#"> <img height="39"
				alt="View Cart/Checkout" src="../images/viewcart.jpg" width="183" /></a>
			<a title="About Us" href="#"> <img height="39" alt="About Us"
				src="../images/aboutus.jpg" width="115" /></a> <a title="Contact Us"
				href="#"> <img height="39" alt="Contact Us"
				src="../images/contactus.jpg" width="126" /></a></center>
			</td>
		</tr>
	</tbody>
</table>


<form name="frm" method="post" action="<%=Constants.s_PAGE_ROOT_WOOD%>servlet/WoodServlet" id="mainForm">
<center>
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0"
	style="border-collapse: collapse;" width="1024"
	style="background-image:url(images/pageBackground.jpg); PADDING-BOTTOM: 100px; background-repeat: no-repeat; PADDING-LEFT: 0px ">
	<tr>
		<td width=20>&nbsp;</td>
		<td width="150" id="ctl00_leftColumn" valign="top"><br>
		<br>
		<br>
		<table border="0" cellpadding="0" cellspacing="0"
			style="background-image: url(images/sidemenubg.jpg); PADDING-BOTTOM: 200px; vertical-align: top; PADDING-LEFT: 0px; PADDING-RIGHT: 30px; PADDING-TOP: 0px">
			<tr>
				<td align=left><br>
				<br>
				<br> <!--<img src="images/shop.jpg" alt="Browse Categories" />-->
				<center>
				<h1 class="leftMenuFont">Shop</h1>
				</center>
				<br>
				<br>
				<ul>
					<ul>
						<%
							for (int i = 0; i < categories.length; i++) {
						%>
						<li><a href="index.jsp?cat=<%=categories[i].getId()%>"
							title=""><%=categories[i].getName()%></a></li>
						<br>
						<%
							}
						%>
					</ul>
				</ul>
				</td>
			</tr>
		</table>
		</td>
		<br>
		<br>
		<td width=50>&nbsp;</td>
		<td width="800" id="ctl00_centerColumn" style="vertical-align: top; ">
		<h1 class="leftMenuFont">My Order Summary</h1>
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
												<td>$<%=payment.getAmount()%></td>
											</tr>
											<tr>
												<td width="130">Card Owner:</td>
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
						<td colspan="2" align="left">
						<table border="0" width="100%" cellspacing="1" cellpadding="2">
							<tr>
								<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2">
									<tr>
										<br>
										<br>
										<td align="left" width=100>
											<a id="btnCheckout" href="javascript: document.frm.submit();" class="buttontextp">ORDER NOW</a>
										</td>
										<td align="left">
											<a id="btnCancel" href="javascript: cancelOrder()" class="buttontextp">CANCEL ORDER</a>
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

<center>
<table cellspacing="0" cellpadding="0">
	<tbody>
		<tr>
			<td><a href="/">Home</a> | <a href="/about-us.aspx">About Us</a>
			| <a href="/contact-us.aspx">Contact Us</a> | <a href="/account.aspx">My
			Account</a> | <a href="/shipping-policy.aspx">Shipping Policy</a> | <a
				href="/return-policy.aspx">Return Policy</a> | <a
				href="/privacy-policy.aspx">Privacy Policy</a> | <a
				href="/sitemap.aspx">Sitemap</a> | <a href="/help.aspx">Cart
			Help</a></td>
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
