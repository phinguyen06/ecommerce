<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.Payment"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Shipping"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.User"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.cache.ShipperDataProvider"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>

<%
	String testCreditCardNo = "";
	String message = (String)session.getAttribute("ERROR");;
	WoodCategory[] categories = new WoodCategory[1];
	Payment payment = new Payment();
	try {
		categories = WoodCategoryDataProvider.getInstance().getAllCategories();
		if (request.getParameter("hdnSubmit") != null) {
			OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
			//gather all field data
			Shipping shipping = new Shipping();
			shipping.setOrderId(orderProducts[0].getOrder().getOrderId());	
			shipping.setVendor(ShipperDataProvider.getInstance().getShipper(request.getParameter("rdShipper")));
			orderProducts[0].getOrder().setShipping(shipping);
			session.setAttribute(Constants.s_CUSTOMER_ORDER_CART, orderProducts);
		}
		if( session.getAttribute(Constants.s_CUSTOMER_ORDER_CART) != null )
		{
			OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
			payment = orderProducts[0].getOrder().getPayment();
		}
		
		if( session.getAttribute(Constants.s_LOGGIN) != null )
		{
			//login validation
			User user = (User)session.getAttribute(Constants.s_LOGGIN);	
			if ("brandon11151@yahoo.com".equals(user.getEmail()))
				testCreditCardNo = "4357065968665137";

		}

		
		session.removeAttribute("ERROR");
	} catch (Exception ex) {
		session.setAttribute("ERROR", ex.getMessage());
		message = ex.getMessage();
		//response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"shippingInfo.jsp");
	} finally {
	}
	
	//add counter for page usages
	try{
		Tracker t = new Tracker();
		t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
		t.setPage("paymentMethod");
		t.setClientId(request.getRemoteAddr());
		TrackerDataProvider.getInstance().addTracker(t);
	}
	catch(Exception ignore){}	
%>


<html>
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
<form name="frm" method="post" action="orderSummary.jsp" id="mainForm">
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
	
<table cellspacing="0" cellpadding="0" border="0" width="1024"
	style="background-image:url(images/pageBackground7.jpg); PADDING-BOTTOM: 400px; background-repeat: no-repeat; PADDING-LEFT: 0px; border-collapse: collapse; ">
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
		<td width=50>&nbsp;</td>
		<td width="831" style="vertical-align: top; " valign="top">
		<br><br>
		<h1 class="leftMenuTitleFont">My Payment Information</h1>
		<br />
		<table cellspacing="0" border="0" style="width: 100%; border-collapse: collapse;">
			<tr>
				<td width="33%" class="containerBody" style="width: 33.33333%;" align="left">
					<% if( message != null ){ %>
						<h4><i><font color=red><%=message%></font></i></h4>
					<% } %>
				<table border="0" align="center" cellpadding="0"
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
												<td colspan="4" class=main align=left><img
													src="../images/vendor/cards.gif" alt="Credit cards accepted by using Paypal" border="0" /></td>
											</tr>											
											<tr>
												<td colspan="2">
												<table border="0" width="100%" cellspacing="0"
													cellpadding="2">
													<tr>
														<td class="main" colspan="3"><b>Credit or Debit Card (Processed securely by PayPal)</b></td>
													</tr>
													<tr>
														<td colspan="3">
														<table border="0" cellspacing="0" cellpadding="2"
															align=left>
															<tr>
																<td width="10"><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left>Card Owner:</td>
																<td align=left><img src="images/pixel_trans.gif"
																	width="10" height="1" alt="" border="0" /></td>
																<td align=left><input type="text" name="txtPayPalCardOwner"  maxlength="64"
																	value="<%=payment.getCardHolderName() == null ? "" : payment.getCardHolderName()%>" class="txtinput" /><font color=red> * </font></td>
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
																		<% selected = "Discover".equals(payment.getCardType()) ? "SELECTED" : ""; %>
																		<option value="Discover" <%=selected%>>Discover</option>
																	</select><font color=red> * </font>
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
																	name="txtPayPalCardNo" value="<%=testCreditCardNo%>" maxlength="20" class="txtinput" /><font color=red> * </font></td>
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
																</select><font color=red> * </font></td>
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
																	name="txtPayPalCardCVV" maxlength="6" value="<%=payment.getCardCVV() == null ? "" : payment.getCardCVV()%>" size="5" maxlength="4" /><font color=red> * </font></td>
																<td width="10" align=left><img
																	src="images/vendor/cvvcid.jpg" width="179" height="106"
																	border="0" /></td>
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
													rows="3" maxlength="300" style="width: 100%; height: 70px;"></textarea></td>
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
											<a id="btnCheckout" href="javascript: document.frm.submit();" class="buttontextp"><b>CONTINUE</b></a>
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
