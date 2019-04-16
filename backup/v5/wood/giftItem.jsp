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
<body id="ctl00_bodyTag">

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.WoodProduct"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>
<%@ page import="com.ebiz.data.User"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="java.util.HashMap"%>

<%
String message = "";
WoodCategory[] categories = new WoodCategory[1];
WoodProduct product = new WoodProduct();
OrderWoodProduct[] ordersCart = null;
User user = null;
String prodQuantity = "1";
String productId = null;
boolean hasCart = false;
String categoryName = null;
try
{
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();
	productId = request.getParameter("prod") != null ? request.getParameter("prod") : (String)session.getAttribute(Constants.s_SELECTED_PRODUCT) ; 
	if( productId != null )
	{
		HashMap<String,WoodProduct> map = (HashMap) session.getAttribute(Constants.s_PRODUCT);
		product = (WoodProduct) map.get(productId);
		categoryName = product.getCategory().getName();
		hasCart = session.getAttribute(Constants.s_CUSTOMER_CART) != null;
		//This session is only used when user login and we directed back to this page.  Need to remember what product was selected before
		session.setAttribute(Constants.s_SELECTED_PRODUCT,productId);
		if( "ADD".equals(request.getParameter("hdnOp")) )
		{
			prodQuantity = request.getParameter("txtQuantity");
			if( prodQuantity != null )
			{
				HashMap<String,OrderWoodProduct> cartMap = (session.getAttribute(Constants.s_CUSTOMER_CART) == null) ? new HashMap<String,OrderWoodProduct>() : (HashMap)session.getAttribute(Constants.s_CUSTOMER_CART);
				OrderWoodProduct order = null;
				if( cartMap.get(productId) != null )
				{
					//System.out.println("found session cart productId");
					order = cartMap.get(productId);
					order.setQuantity(order.getQuantity()+Integer.parseInt(prodQuantity));
				}else
				{
					//System.out.println("new session cart productId");
					order = new OrderWoodProduct();
					order.setWoodProduct(product);
					order.setQuantity(Integer.parseInt(prodQuantity));
				}
				cartMap.put(productId, order);
				session.setAttribute(Constants.s_CUSTOMER_CART, cartMap);
				hasCart = true;
				//System.out.println("Session Quantity:"+transaction.getQuantity());
			}
		}
		HashMap<String,OrderWoodProduct> cartMap = (HashMap) session.getAttribute(Constants.s_CUSTOMER_CART);
		if( map != null && map.size() > 0 )
			ordersCart = CustomerSession.getOrders(cartMap);
		//login validation
		user = (User)session.getAttribute(Constants.s_LOGGIN);
	}
	else
	{
		message = "No product selected";
	}
}	
catch(Exception ex)
{
	session.setAttribute("ERROR",ex.getMessage());
	message = ex.getMessage();
}
finally
{
}	



//add counter for page usages
try{
	Tracker t = new Tracker();
	t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
	if( productId != null ) t.setProductId(Integer.parseInt(productId));
	t.setPage("giftItem");
	t.setClientId(request.getRemoteAddr());
	TrackerDataProvider.getInstance().addTracker(t);
}
catch(Exception ignore){}

%>

<script language="JavaScript" type="text/javascript" src="include/wood.js"></script>

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

<%=message%>


<form name="frm" method="post" action="giftItem.jsp" id="mainForm">
<center>
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0" width="1024"
	style="background-image:url(/ebiz/wood/images/pageBackground2.jpg); PADDING-BOTTOM: 100px; background-repeat: no-repeat; PADDING-LEFT: 0px; ">
	<tr>
		<td width=20>&nbsp;</td>
		<td width="320" valign="top"><br>
		<br>
		<br>
		<table border="0" cellpadding="0" cellspacing="0" width="100%"
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
		<br>
		<h1 class="leftMenuTitleFont"><%=categoryName%></h1>
		<br />
		<center><a id="btnReturn" href="index.jsp">BACK TO PREVIOUS PAGE</a></center> <br>
		<br>

		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			border="0" style="width: 100%; border-collapse: collapse;">
			<tr>
				<td width="33%" style="width: 33.33333%;" align=center><img
					alt="<%=product.getName()%>" src="<%=product.getImageURL()%>"
					class="product-list-img" />
				<div>
				<h5><%=product.getName()%></h5>
				<br>
				Our products are the finest quality wood that is red to brown with a finer texture Asian lumber.<br>  
				It made of high quality 100% lumber finish in high Gloss.
				<br><br>
				Its measurements are: <%=Math.round(product.getLength())%>"L x <%=Math.round(product.getWidth())%>"W x <%=Math.round(product.getHeight())%>"H
				<br><br>
				Cost for each item: <%=product.getPrice()%>
				<br><br><label for="txtQuantity">Quantity:</label> <input name="txtQuantity"
					type="text" value="<%=prodQuantity%>" maxlength="10" size="3" id="txtQuantity"
					class="textbox-center" /> <br>
				<br> Shipping: $3.99 US Postal Service First Class Mail 
				<br>
				<br> Payments: 
				<img alt="PayPal" src="../images/vendor/logoPayPal.gif"
					class="vendor-logo" /> <br>
				<b><br>
				<a id="btnAddToCart3" href="javascript:onAddToCart(<%=product.getProductId()%>,0)" class="buttontextp">ADD TO CART</a> 
				<% if( hasCart ) { %> 
						&nbsp;| &nbsp; <a id="btnAddToCart3" href="cartSummary.jsp" class="buttontextp">CHECK OUT</a></div>
				<% } %>				
				</td>
			</tr>
		</table>
<input type=hidden name=hdnOp>
<input type=hidden name=prod value="<%=product.getProductId()%>">
<input type=hidden name=hdnItem>
		
</form>		
		</td>
		<td width=20>&nbsp;</td>
		<td valign="top"><br><br><br>
<form name="frmLogon" method="post" action="<%=Constants.s_PAGE_ROOT%>servlet/LoginServlet">		
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td>
						<table cellspacing="2" cellpadding="2" border="0" width=100%
							style="background-image: url(images/sidemenubg.jpg); PADDING-BOTTOM: 10px; vertical-align: top; PADDING-LEFT: 10px; PADDING-RIGHT: 10px; PADDING-TOP: 0px">			
							<tr>
								<td colspan=2>&nbsp;</td>
							</tr>
							<tr>
								<td colspan=2 class="rightMenuTitleFont">My Account</td>
							</tr>
						<% if( user != null ){ %>
							<tr>
								<td colspan=2><br>Welcome back <b><%=user.getCustomer().getFirstName()%> <%=user.getCustomer().getLastName()%></b><br></td>			
							</tr>
						<% }else{ %>
							<tr>
								<td align=right><br>Email:</td>
								<td align=left><input type=text name="txtEmail" size=15></td>			
							</tr>
							<tr>
								<td align=right>Password:</td>
								<td align=left><input type=password name="txtPassword" size=15></td>			
							</tr>
							<tr>
								<td align=center colspan=2><br>
									<a href="javascript: document.frmLogon.submit();"><b>Logon</b></a>&nbsp;&nbsp; | &nbsp;&nbsp;		
									<a href="javascript: resetLogon(document.frmLogon)"><b>Clear</b></a><br>
								</td>
							</tr>
						<% } %>							
						</table>
					</td>
				</tr>
				<tr>
					<td><br>
						<table cellspacing="2" cellpadding="2" border="0" width=100%
							style="background-image: url(images/sidemenubg.jpg); PADDING-BOTTOM: 10px; vertical-align: top; PADDING-LEFT: 10px; PADDING-RIGHT: 10px; PADDING-TOP: 0px">
							<tr>
								<td align=center class="rightMenuTitleFont" colspan=2><br>Your Shopping Cart</td>
							</tr>
						<% if( ordersCart == null ){ %>
							<tr>
								<td colspan=2>No item has been selected.</td>
							</tr>
						<% }else{ 
								float total = 0f;
								for( int i=0; i<ordersCart.length; i++ ){
									total += (ordersCart[i].getWoodProduct().getPrice()*ordersCart[i].getQuantity());
						%>
							<tr>
								<td colspan=2 align=left><%=i+1%>) <%=ordersCart[i].getWoodProduct().getName()%> $<%=ordersCart[i].getWoodProduct().getPrice()%></td>
							</tr>						
						<% 		} %>
						
							<tr>
								<td align=right><b>Total: </b>
								<td align=center><b>&nbsp;$<%=total%></b>
							</tr> 
						<% }	%>
						</table>
					</td>
				</tr>				
				<tr>
					<td><br>
						<table cellspacing="2" cellpadding="2" border="0" width=100%
							style="background-image: url(images/sidemenubg.jpg); PADDING-BOTTOM: 10px; vertical-align: top; PADDING-LEFT: 10px; PADDING-RIGHT: 10px; PADDING-TOP: 0px">
							<tr>
								<td align=center class="rightMenuTitleFont"><br>Cards We Accept</td>
							</tr>
							<tr>
								<td><img src="../images/vendor/cards.gif" alt="Browse Categories" /></td>
							</tr>
						</table>
					</td>
				</tr>				
			</table>
<input type=hidden name=hdnNextPage value="<%=Constants.s_PAGE_ROOT_WOOD%>giftItem.jsp">
<input type=hidden name=prod value="<%=product.getProductId()%>">
</form>			
		</td>		
		<td width=20>&nbsp;</td>
	</tr>
</table>
<br><br>
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
