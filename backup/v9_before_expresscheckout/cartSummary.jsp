<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.WoodProduct"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Order"%>
<%@ page import="com.ebiz.data.Payment"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.User"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>

<%
String message = null;
WoodCategory[] categories = new WoodCategory[1];
OrderWoodProduct[] orderProducts = new OrderWoodProduct[1];
User user = null;
String prodQuantity = "1";
double totalCharges = 0d;
try
{
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();	
	HashMap<String,OrderWoodProduct> cartMap = (HashMap)session.getAttribute(Constants.s_CUSTOMER_CART);
	//do not allow customer to move forward if shopping cart is empty!
	if( cartMap == null )
		throw new Exception("Your Shopping Cart is empty.  Please choose product before Checkout.");
	//did customer request to remove a product from this shopping cart?
	if( request.getParameter("hdnRemoveProd") != null ){
			cartMap.remove(request.getParameter("hdnRemoveProd"));
			//Cart is empty, remove it from Session
			if( cartMap.size() == 0 ){
				cartMap = null;
				session.removeAttribute(Constants.s_CUSTOMER_CART);
				throw new Exception("Your Shopping Cart is empty.  Please choose product before Checkout.");
			}
	}
	
	orderProducts = new OrderWoodProduct[cartMap.size()];
	Set set = cartMap.keySet();
	int i=0;
	for( Iterator iter=set.iterator(); iter.hasNext(); i++)
	{
		orderProducts[i] = cartMap.get(iter.next());
		totalCharges += orderProducts[i].getWoodProduct().getPrice()*orderProducts[i].getQuantity();
	}	

	Order order = new Order();
	order.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
	order.setAmount(totalCharges);
	order.setPayment(new Payment());
	//Need to do this for the first object only.  All should have the same order.  To save cache MEMORY
	orderProducts[0].setOrder(order);
	//store session for later use
	session.setAttribute(Constants.s_CUSTOMER_ORDER_CART, orderProducts);
	
	//login validation
	user = (User)session.getAttribute(Constants.s_LOGGIN);
	
	// clear ERROR Session
	session.removeAttribute("ERROR");
}	
catch(Exception ex)
{
	//session.setAttribute("ERROR",ex.getMessage());
	message = ex.getMessage();
}
finally
{
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
<center>
<form name="frm" method="post" action="cartSummary.jsp">
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
style="background-image:url(images/pageBackground7.jpg); PADDING-BOTTOM: 200px; background-repeat: no-repeat; PADDING-LEFT: 0px;">
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
		<td id="ctl00_centerColumn" style="vertical-align: top; "><br>
		<br>
	<% if( message != null ){  %>	
		<td colspan="2" align=center valign="top"><br><br><h3><i><font color=red><%=message%></font></i></h3></td>
	<% }else{ %>
		<td colspan="2" align=left valign="top"><br><br>	
		<h1 class="leftMenuTitleFont">My Cart Summary</h1>
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			cellpadding="2" border="3" style="width: 100%; border-collapse: ">
			<tr>
				<th align=center colspan=3>Product
				</th>
				<th width=50 align=center>Quantity
				</th>
				<th width=50 align=center>Item Price
				</th>
				<th width=50 align=center> Total Cost
				</th>
			</tr>

			<% for(int i=0; i<orderProducts.length; i++ ) { %>
			<tr>
				<td align=center width=50><a id="btnCheckout" href="javascript: removeItemFromCart('<%=orderProducts[i].getWoodProduct().getProductId()%>')" class="buttontextp">Remove</a></td>
				<td width="100">
					<img alt="<%=orderProducts[i].getWoodProduct().getName()%>"
					src="<%=orderProducts[i].getWoodProduct().getCategory().getUrlPath()+"s"+orderProducts[i].getWoodProduct().getImageName()%>"
					class="containerBody-img" />
				</td>
				<td>
					<h5><%=orderProducts[i].getWoodProduct().getName()%></h5>
				</td>
				<td align=right><%=orderProducts[i].getQuantity()%></td>
				<td align=right>$<%=orderProducts[i].getWoodProduct().getPrice()%></td>
				<td align=right>$<%=orderProducts[i].getWoodProduct().getPrice()*orderProducts[i].getQuantity()%></td>				
			</tr>
			<% } %>
			<tr>
				<td colspan=5 align=right>Total Charges</td>
				<td align=right>$<%=com.ebiz.utils.Util.formatNumber(totalCharges, 2)%></td>
			</tr>
		</table>
		
		<% if( message == null ){  %>	
		<center><br><br>
		<table cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td><b>
						<a id="btnCheckout" href="javascript: loadPage(document.frm, 'https://localhost<%=Constants.s_PAGE_ROOT_WOOD%>createAccount.jsp')" class="buttontextp">CONTINUE TO CHECKOUT</a> 
						&nbsp;| &nbsp; 
						<a id="btnCancel" href="javascript: cancelOrder()" class="buttontextp">CANCEL</a>
					</b>		
				</td>
			</tr>
		</table>
<input type="hidden" name="hdnRemoveProd" value="">
<input type="hidden" name="hdnCancelOrder" value="">
</form>		
		</center>
		<% } //closing message null for button %>
				
		</td>
		<% } //closing no product to show %>
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
								<td align=center class="rightMenuTitleFont"><br>Cards We Accept</td>
							</tr>
							<tr>
								<td><img src="../images/vendor/cards.gif" alt="Browse Categories" /></td>
							</tr>
						</table>
					</td>
				</tr>				
			</table>
<input type=hidden name=hdnNextPage value="<%=Constants.s_PAGE_ROOT_WOOD%>cartSummary.jsp">
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
