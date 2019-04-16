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
<%@ page import="com.ebiz.data.WoodProduct"%>
<%@ page import="com.ebiz.data.State"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Customer"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.cache.StateDataProvider"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="com.ebiz.db.ReferenceDB"%>
<%@ page import="java.util.HashMap"%>


<%
	String message = (String)session.getAttribute("ERROR");
	WoodCategory[] categories = new WoodCategory[1];
	State[] states = new State[1];
	Customer customer = new Customer();
	try {
		categories = WoodCategoryDataProvider.getInstance().getAllCategories();
		states = StateDataProvider.getInstance().getStates();
		
		if( session.getAttribute(Constants.s_CUSTOMER_ORDER_CART) != null )
		{
			OrderWoodProduct[] orderProducts = (OrderWoodProduct[])session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
			customer = orderProducts[0].getOrder().getCustomer();
			if(customer==null) customer = new Customer();
		}
		// clear ERROR Session
		session.removeAttribute("ERROR");
	} catch (Exception ex) {
		session.setAttribute("ERROR", ex.getMessage());
		message = ex.getMessage();
	} finally {
	}
	
	//add counter for page usages
	try{
		Tracker t = new Tracker();
		t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
		t.setPage("createAccount");
		t.setClientId(request.getRemoteAddr());
		TrackerDataProvider.getInstance().addTracker(t);
	}
	catch(Exception ignore){}
	
%>

<script language="JavaScript" type="text/javascript" src="include/wood.js"></script>


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
			<table cellspacing="0" cellpadding="0" width="800" align=center>
			  <tr>
				<td background="../images/menubg.jpg">		
				 	<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" HEIGHT: 17px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px;" title="Return Home" href="<%=Constants.s_PAGE_ROOT_WOOD%>"><font COLOR="white">&nbsp;&nbsp;&nbsp;Home&nbsp;&nbsp;&nbsp;</font></a>
				</td>
				<td background="../images/menubg.jpg" align=center >				
			 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" HEIGHT: 17px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px;" title="My Account" href="Logon.jsp"><font COLOR="white">&nbsp;&nbsp;&nbsp;My Account&nbsp;&nbsp;&nbsp;</font></a>
			 	</td>
				<td background="../images/menubg.jpg" align=center>
			 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" HEIGHT: 17px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px;" style="TEXT-DECORATION: none; MARGIN-BOTTOM: 0px; PADDING-BOTTOM: 0px" title="View Cart and Checkout" href="cartSummary.jsp"><font COLOR="white">&nbsp;&nbsp;&nbsp;View Cart/Checkout&nbsp;&nbsp;&nbsp;</font></a>
				</td>
				<td background="../images/menubg.jpg" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" HEIGHT: 17px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px;" title="About Us" href="#"><font COLOR="white">&nbsp;&nbsp;&nbsp;About Us&nbsp;&nbsp;&nbsp;</font></a>
				</td>
				<td background="../images/menubg.jpg" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" HEIGHT: 17px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px;" title="Contact Us" href="#"><font COLOR="white">&nbsp;&nbsp;&nbsp;Contact Us&nbsp;&nbsp;&nbsp;</font></a>
				</td>
				<td><h3><font COLOR="black">&nbsp;</font></h3></td>
		      </tr>
			</table>					
			</td>
		</tr>
	</tbody>
</table>
</center>


<form name="frm" method="post" action="paymentMethod.jsp" id="mainForm">
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
		<td width=10>&nbsp;</td>
		<td width="831" id="ctl00_centerColumn" style="vertical-align: top; "><br>
		<h1 class="leftMenuFont">My Account Information</h1>
		<br />
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
						<table border="0" width="100%" cellspacing="0" cellpadding="2">
							<tr>
								<td class="main" align="left"><b>New customer create
								your account</b></td>
								<td align="right"><span class="inputRequirement">*
								Required information</span></td>
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
									<tr class="infoBoxContents">
										<td>
										<table border="0" cellspacing="2" cellpadding="1">
											<tr>
												<td>
												<table width="100%" border="0" cellpadding="1"
													cellspacing="1">
													<tr>
														<td width="130" align="left">First Name:</td>
														<td align="left"><input type="text" name="txtFName" value="<%=customer.getFirstName() == null ? "" : customer.getFirstName()%>"
															class="txtinput" />&nbsp;<span class="inputRequirement">*</span></td>
													</tr>
													<tr>
														<td align="left">Last Name:</td>
														<td><input type="text" name="txtLName" value="<%=customer.getLastName() == null ? "" : customer.getLastName()%>"
															class="txtinput" />&nbsp;<span class="inputRequirement">*</span></td>
													</tr>

													<tr>
														<td align="left">E-Mail:</td>
														<td><input type="text" name="txtEmail" value="<%=customer.getEmail() == null ? "" : customer.getEmail()%>"
															class="txtinput" />&nbsp;<span class="inputRequirement">*</span></td>
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
						<td colspan="2" class="main" align="left"><b>Your Billing
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
												<td><input type="text" name="txtAddress1" value="<%=customer.getAddress1() == null ? "" : customer.getAddress1()%>"
													class="txtinput" />&nbsp;<span class="inputRequirement">*</span></td>
											</tr>
											<tr>
												<td>Address Line 2:</td>
												<td><input type="text" name="txtAddress2" value="<%=customer.getAddress2() == null ? "" : customer.getAddress2()%>"
													class="txtinput" />&nbsp;</td>
											</tr>
											<tr>
												<td>City:</td>
												<td><input type="text" name="txtCity" class="txtinput"  value="<%=customer.getCity() == null ? "" : customer.getCity()%>"/>&nbsp;<span
													class="inputRequirement">*</span></td>
											</tr>
											<tr>
												<td>State/Province:</td>
												<td><select name="slState" style="width: 200px;">
													<option value="" SELECTED>Please Select</option>
													<%
														String selected = "";
														for (int i = 0; i < states.length; i++) {
															selected = "";
															if( states[i].getCode().equals(customer.getState()) ){
																selected = "SELECTED";
															}
																
													%>
															<option value="<%=states[i].getCode()%>" <%=selected%>><%=states[i].getName()%></option>
													<% } %>

												</select> <span class="inputRequirement">* </td>
											</tr>
											<tr>
												<td width="130">Post Code:</td>
												<td><input type="text" name="txtZip" class="txtinput" value="<%=customer.getZip() == null ? "" : customer.getZip()%>" />&nbsp;<span
													class="inputRequirement">*</span></td>
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
												<td colspan=2><input type="checkbox" name="chkSameAddress"
													onclick="javascript: updateShipAddress()" class="txtinput" />&nbsp;&nbsp;Same as Billing Address</td>
											</tr>
											<tr>
												<td width="130">Address Line 1:</td>
												<td><input type="text" name="txtShipAddress1" value="<%=customer.getShipAddress1() == null ? "" : customer.getShipAddress1()%>"
													class="txtinput" />&nbsp;<span class="inputRequirement">*</span></td>
											</tr>
											<tr>
												<td>Address Line 2:</td>
												<td><input type="text" name="txtShipAddress2" value="<%=customer.getShipAddress2() == null ? "" : customer.getShipAddress2()%>"
													class="txtinput" />&nbsp;</td>
											</tr>
											<tr>
												<td>City:</td>
												<td><input type="text" name="txtShipCity" value="<%=customer.getShipCity() == null ? "" : customer.getShipCity()%>"
													class="txtinput" />&nbsp;<span class="inputRequirement">*</span></td>
											</tr>
											<tr>
												<td>State/Province:</td>
												<td><select name="slShipState" style="width: 200px;">
													<option value="" SELECTED>Please Select</option>
													<%
														for (int i = 0; i < states.length; i++) {
															selected = "";
															if( states[i].getCode().equals(customer.getState()) ){
																selected = "SELECTED";
															}
																
													%>
															<option value="<%=states[i].getCode()%>" <%=selected%>><%=states[i].getName()%></option>
													<% } %>

												</select> <span class="inputRequirement">* </td>
											</tr>
											<tr>
												<td width="130">Post Code:</td>
												<td><input type="text" name="txtShipZip" value="<%=customer.getShipZip() == null ? "" : customer.getShipZip()%>"
													class="txtinput" />&nbsp;<span class="inputRequirement">*</span>
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
												<td><input type="text" name="txtPhone" class="txtinput"  value="<%=customer.getContactPhone() == null ? "" : customer.getContactPhone()%>"/>&nbsp;<span
													class="inputRequirement">*</span></td>
											</tr>
											<tr>
												<td>Fax Number:</td>
												<td><input type="text" name="txtFax" value="<%=customer.getContactFax() == null ? "" : customer.getContactFax()%>"
													class="txtinput" />&nbsp;</td>
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
						Password</b></td>
					</tr>
					<tr>
						<td colspan="2" align="left">
						<table width="100%" border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td>
								<table border="0" width="100%" cellspacing="1" cellpadding="2"
									class="infoBox">
									<tr>
										<td class="containerBody">
										<table border="0" cellpadding="1" cellspacing="2">
											<tr>
												<td width="130">Password:</td>
												<td><input type="password" name="txtPassword"
													maxlength="40" class="txtinput" />&nbsp;<span
													class="inputRequirement">*</span></td>
											</tr>
											<tr>
												<td>Confirm Pass:</td>
												<td><input type="password" name="txtConfPassword"
													maxlength="40" class="txtinput" />&nbsp;<span
													class="inputRequirement">*</span></td>
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
										<td align="left">
											<a id="btnCheckout" href="javascript: createAccountSubmit();" class="buttontextp">CONTINUE</a>
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
		<td width=20>&nbsp;</td>
	</tr>
</table>
</center>
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
			<td align="center">© 2009 www.eBiz.com</td>
		</tr>
	</tbody>
</table>
</center>

</body>
</html>
