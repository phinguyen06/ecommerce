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
<%@ page import="javax.servlet.http.HttpServletRequest"%>



<%
	String message = (String)session.getAttribute("ERROR");;
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

		return "";
	}%>


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


<form name="frm" method="post" action="orderSummary.jsp"
	id="mainForm">
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
				</td>
			</tr>
		</table>
		</td>
		<br>
		<br>
		<td width=50>&nbsp;</td>
		<td width="831" id="ctl00_centerColumn" style="vertical-align: top; "><br>
		<h1 class="leftMenuFont">My Payment Information</h1>
		<br />
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			border="0" style="width: 100%; border-collapse: collapse;">
			<tr>
				<td width="33%" class="containerBody" style="width: 33.33333%;">
					<% if( message != null ){ %>
						<h4><i><font color=red><%=message%></font></i></h4>
					<% } %>
				<table width="870" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td class="containerBody">
						<table border="0" width="100%" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table border="0" width="100%" cellspacing="1" cellpadding="2">
									<tr class="containerBody">
										<td>
										<table border="0" width="100%" cellspacing="0" cellpadding="2">
											<tr>
												<td><img src="images/pixel_trans.gif" width="10"
													height="1" alt="" border="0" /></td>
												<td width="50%" valign="top" alight=left>Please select
												the preferred payment method to use on this order.</td>
												<td width="50%" valign="top" align="right"><b>Please
												Select</b><br>
												<img src="../images/vendor/arrow_east_south.gif" alt=""
													border="0" /></td>
												<td><img src="images/pixel_trans.gif" width="10"
													height="1" alt="" border="0" /></td>
											</tr>
											<tr>
												<td><img src="images/pixel_trans.gif" width="10"
													height="1" alt="" border="0" /></td>
												<td colspan="2">
												<table border="0" width="100%" cellspacing="0"
													cellpadding="2">
													<tr>
														<td width="10"><img src="images/pixel_trans.gif"
															width="10" height="1" alt="" border="0" /></td>
														<td class="main" colspan="3"><b>Credit or Debit
														Card (Processed securely by PayPal)</b></td>
														<td class="main" align="right">
															<input type="radio" name="rdPaymentType" value="paypal" CHECKED/></td>
														<td width="10"><img src="images/pixel_trans.gif"
															width="10" height="1" alt="" border="0" /></td>
													</tr>
													<tr>
														<td width="10"><img src="images/pixel_trans.gif"
															width="10" height="1" alt="" border="0" /></td>
														<td colspan="4">
														<table border="0" cellspacing="0" cellpadding="2"
															align=left>
															<tr>
																<td width="10"><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left>Card Owner:</td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left><input type="text" name="txtPayPalCardOwner"
																	value="<%=payment.getCardHolderName() == null ? "" : payment.getCardHolderName()%>" class="txtinput" /></td>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
															</tr>
															<tr>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
																<td align=left align=left>Card Type:</td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left>
																	<select name="slPayPalCardtype">
																		<% String selected = ("Visa".equals(payment.getCardType())) ? "SELECTED" : ""; %>
																		<option value="Visa" <%=selected%>>Visa</option>
																		<% selected = "MasterCard".equals(payment.getCardType()) ? "SELECTED" : ""; %>
																		<option value="MasterCard" <%=selected%>>MasterCard</option>
																	</select>
																</td>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
															</tr>

															<tr>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
																<td align=left>Card Number:</td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left><input type="text"
																	name="txtPayPalCardNo" value="<%=payment.getCardNumber() == null ? "" : payment.getCardNumber()%>" class="txtinput" /></td>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
															</tr>
															<tr>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
																<td align=left>Card Expiry Date:</td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left><select name="slPayPalCardExpMonth">
																	<option value="01">January</option>
																	<option value="02">February</option>
																	<option value="03">March</option>
																	<option value="04">April</option>
																	<option value="05">May</option>
																	<option value="06">June</option>
																	<option value="07">July</option>
																	<option value="08">August</option>
																	<option value="09">September</option>
																	<option value="10">October</option>
																	<option value="11">November</option>
																	<option value="12">December</option>
																</select>&nbsp;<select name="slPayPalCardExpYear">
																	<option value="2009">2009</option>
																	<option value="2010">2010</option>
																	<option value="2011">2011</option>
																	<option value="2012">2012</option>
																	<option value="2013">2013</option>
																	<option value="2014">2014</option>
																	<option value="2015">2015</option>
																	<option value="2016">2016</option>
																	<option value="2017">2017</option>
																	<option value="2018">2018</option>
																</select></td>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
															</tr>
															<tr>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
																<td align=left>Card Security Code (CVV2):</td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left><input type="text"
																	name="txtPayPalCardCVV" value="<%=payment.getCardCVV() == null ? "" : payment.getCardCVV()%>" size="5" maxlength="4" /></td>
																<td width="10" align=left><img
																	src="../images/cvvcid.jpg" width="179" height="106"
																	border="0" /></td>
															</tr>
														</table>
														</td>
														<td width="10" align=left><img
															src="images/pixel_trans.gif" width="10" height="1" alt=""
															border="0" /></td>
													</tr>
												</table>
												</td>
												<td align=left><img src="images/pixel_trans.gif"
													width="10" height="1" alt="" border="0" /></td>
											</tr>
											<tr>
												<td align=left><img src="images/pixel_trans.gif"
													width="10" height="1" alt="" border="0" /></td>
												<td colspan="2">
												<table border="0" width="100%" cellspacing="0"
													cellpadding="2" align=left>
													<tr>
														<td width="10" align=left><img
															src="images/pixel_trans.gif" width="10" height="1" alt=""
															border="0" /></td>
														<td colspan="3" align=left><b>PayPal (We only
														ship to confirmed paypal addresses)</b></td>
														<td align="right">
															<input type="radio" name="rdPaymentType" value="paypal_ipn" /></td>
														<td width="10" align=left><img
															src="images/pixel_trans.gif" width="10" height="1" alt=""
															border="0" /></td>
													</tr>
												</table>
												</td>
												<td><img src="images/pixel_trans.gif" width="10"
													height="1" alt="" border="0" /></td>
											</tr>
											<tr>
												<td width="10" align=left><img
													src="images/pixel_trans.gif" width="10" height="1" alt=""
													border="0" /></td>
												<td colspan="4" class=main align=left><img
													src="../images/vendor/paypal_logos.jpg" width="339"
													height="70"
													alt="Credit cards accepted by HiSunglasses using Paypal"
													border="0" /></td>
												<td width="10" align=left><img
													src="images/pixel_trans.gif" width="10" height="1" alt=""
													border="0" /></td>
											</tr>
											<tr>
												<td><img src="images/pixel_trans.gif" width="10"
													height="1" alt="" border="0" /></td>
												<td colspan="2">
												<table border="0" width="100%" cellspacing="0"
													cellpadding="2" align=left>
													<tr>
														<td width="10" align=left><img
															src="images/pixel_trans.gif" width="10" height="1" alt=""
															border="0" /></td>
														<td colspan="3"><b>Credit Card USD (Visa Only)</b></td>
														<td align="right">
															<input type="radio" name="rdPaymentType" value="Visa" /></td>
														<td width="10" align=left><img
															src="images/pixel_trans.gif" width="10" height="1" alt=""
															border="0" /></td>
													</tr>
													<tr>
														<td width="10" align=left><img
															src="images/pixel_trans.gif" width="10" height="1" alt=""
															border="0" /></td>
														<td colspan="4" align=left>
														<table border="0" cellspacing="0" cellpadding="2">
															<tr>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
																<td align=left>Credit Card Owner:</td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left><input type="text"
																	name="txtCardOwner" class="txtinput" /></td>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
															</tr>

															<tr>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
																<td align=left>Credit Card Number:</td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left><input type="text"
																	name="txtCardNo" class="txtinput" /></td>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
															</tr>
															<tr>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
																<td align=left>Credit Card Expiry Date:</td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left><select
																	name="slCardExpMonth">
																	<option value="01">January</option>
																	<option value="02">February</option>
																	<option value="03">March</option>
																	<option value="04">April</option>
																	<option value="05">May</option>
																	<option value="06">June</option>
																	<option value="07">July</option>
																	<option value="08">August</option>
																	<option value="09">September</option>
																	<option value="10">October</option>
																	<option value="11">November</option>
																	<option value="12">December</option>
																</select>&nbsp;<select name="slCardExpYear">
																	<option value="09">2009</option>
																	<option value="10">2010</option>
																	<option value="11">2011</option>
																	<option value="12">2012</option>
																	<option value="13">2013</option>
																	<option value="14">2014</option>
																	<option value="15">2015</option>
																	<option value="16">2016</option>
																	<option value="17">2017</option>
																	<option value="18">2018</option>
																</select></td>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
															</tr>
															<tr>
																<td width="10" align=left><img
																	src="images/pixel_trans.gif" width="10" height="1"
																	alt="" border="0" /></td>
																<td align=left>CVV Code: </td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left><input type="text"
																	name="txtCardCVV" SIZE=4, MAXLENGTH=4 /></td>
																<td width="10" align=left><img
																	src="../images/cvvcid.jpg" width="179" height="106"
																	border="0" /></td>
															</tr>
														</table>
														</td>
														<td width="10">
														<hr />
														</td>
													</tr>
												</table>
												</td>
												<td>
												<hr />
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
						<td>
						<table border="0" width="100%" cellspacing="0" cellpadding="2"
							align=left>
							<tr>
								<td class="main" align=left><b>Add Comments About Your
								Order</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table border="0" width="100%" cellspacing="0" cellpadding="0"
							align=left>
							<tr>
								<td>
								<table class="containerBody" border="0" width="100%"
									cellspacing="1" cellpadding="2" class="infoBox">
									<tr>
										<td>
										<table border="0" width="100%" cellspacing="0" cellpadding="2">
											<tr>
												<td><textarea name="taComments" wrap="" cols="30"
													rows="3" style="width: 100%; height: 70px;"></textarea></td>
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
						<table border="0" width="100%" cellspacing="1" cellpadding="2"
							class="infoBox" align=left>
							<tr class="containerBody">
								<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2">
									<tr>
										<td class="main">&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="containerBody">
						<table border="0" width="100%" cellspacing="1" cellpadding="2"
							class="infoBox" align=left>
							<tr class="containerBody">
								<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2">
									<tr>
										<td class="main"><b>Continue Checkout Procedure</b><br>to
										confirm this order.
										</td>
										<td class="main" align="right">
											<a id="btnCheckout" href="javascript: document.frm.submit();" class="buttontextp">CONTINUE</a>
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
						<table border="0" width="100%" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17%"></td>
								<td width="17%">
								<table border="0" width="100%" cellspacing="0" cellpadding="0">
									<tr>
										<td width="50%"><img src="images/pixel_red.gif"
											width="100%" height="1" alt="" border="0" /></td>
										<td>&nbsp;</td>
										<td width="50%"><img src="images/pixel_red.gif"
											width="100%" height="1" alt="" border="0" /></td>
									</tr>
								</table>
								</td>
								<td width="17%">
								<table border="0" width="100%" cellspacing="0" cellpadding="0">
									<tr>
										<td width="50%"><img src="images/pixel_red.gif"
											width="100%" height="1" alt="" border="0" /></td>
										<td width="50%"><img src="images/pixel_red.gif" width="1"
											height="5" alt="" border="0" /></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td align="center" width="25%" class="checkoutBarFrom"><a
									href="http://www.hisunglasses.com/shopping_cart.php"
									class="checkoutBarFrom">Review Cart</a>
								<td align="center" width="25%" class="checkoutBarCurrent"><a
									href="https://www.hisunglasses.com/checkout_shipping.php"
									class="checkoutBarCurrent">Shipping</a></td>
								<td align="center" width="25%" class="checkoutBarTo">Payment</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			</td>
			</tr>
			</td>
			</tr>
			</tbody>
		</table>
		</center>
		</td>
		<td width=20>&nbsp;</td>
	</tr>
</table>
<input type=hidden name=hdnSubmit value="submit">
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
			<td class="containerFooter" align="center">� 2009 www.eBiz.com
			</td>
		</tr>
	</tbody>
</table>
</center>
</body>
</html>
