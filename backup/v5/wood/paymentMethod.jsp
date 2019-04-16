<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.Payment"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Shipping"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.cache.ShipperDataProvider"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
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


<form name="frm" method="post" action="orderSummary.jsp"
	id="mainForm">
<center>
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0" width="1024"
	style="background-image:url(/ebiz/wood/images/pageBackground.jpg); PADDING-BOTTOM: 0px; background-repeat: no-repeat; PADDING-LEFT: 0px; border-collapse: collapse; ">
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
		<td width=50>&nbsp;</td>
		<td width="831" id="ctl00_centerColumn" style="vertical-align: top; " valign="top"><br>
		<h1 class="leftMenuTitleFont">My Payment Information</h1>
		<br />
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			border="0" style="width: 100%; border-collapse: collapse;">
			<tr>
				<td width="33%" class="containerBody" style="width: 33.33333%;" align="left">
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
																	name="txtPayPalCardNo" value="<%=payment.getCardNumber() == null ? "" : payment.getCardNumber()%>" class="txtinput" /><font color=red> * </font></td>
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
																	name="txtPayPalCardCVV" value="<%=payment.getCardCVV() == null ? "" : payment.getCardCVV()%>" size="5" maxlength="4" /><font color=red> * </font></td>
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
