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
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="java.util.HashMap"%>

<%
String message = "";
WoodCategory[] categories = new WoodCategory[1];
WoodProduct product = new WoodProduct();
String prodQuantity = "1";
boolean hasCart = false;
try
{
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();
	String productId = request.getParameter("prod"); 
	if( productId != null )
	{
		HashMap<String,WoodProduct> map = (HashMap) session.getAttribute(Constants.s_PRODUCT);
		product = (WoodProduct) map.get(productId);
		hasCart = session.getAttribute(Constants.s_CUSTOMER_CART) != null;
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

%>

<script language="javascript">
function onAddToCart()
{
	document.frm.hdnOp.value = "ADD";
	document.frm.submit();	
}
</script>

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

<%=message%>


<form name="frm" method="post" action="giftItem.jsp" id="mainForm">
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
					<% for(int i=0; i<categories.length; i++ ) { %>
					<li><a href="index.jsp?cat=<%=categories[i].getId()%>"
						title=""><%=categories[i].getName()%></a></li>
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
		<td width="831" id="ctl00_centerColumn" style="vertical-align: top; "><br>
		<br>
		<h1 class="leftMenuFont">Air Plane</h1>
		<br />
		<a id="btnReturn" href="index.jsp">BACK TO PREVIOUS PAGE</a> <br>
		<br>
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			border="0" style="width: 100%; border-collapse: collapse;">
			<tr>
				<td width="33%" style="width: 33.33333%;"><img
					alt="<%=product.getName()%>" src="<%=product.getImageURL()%>"
					class="product-list-img" />
				<div>
				<h5><%=product.getName()%></h5>
				<%=product.getDescription()!=null? product.getDescription() : ""%> <br>
				<br>
				<label for="txtQuantity">Quantity:</label> <input name="txtQuantity"
					type="text" value="<%=prodQuantity%>" maxlength="10" size="3" id="txtQuantity"
					class="textbox-center" /> <br>
				<br> Shipping: $3.99 US Postal Service First Class Mail 
				<br>
				<br> Payments: 
				<img alt="PayPal" src="../images/vendor/logoPayPal.gif"
					class="vendor-logo" /> <br>
				<b><br>
				<a id="btnAddToCart3" href="javascript:onAddToCart()" class="buttontextp">ADD TO CART</a> 
				<% if( hasCart ) { %> 
						&nbsp;| &nbsp; <a id="btnAddToCart3" href="cartSummary.jsp" class="buttontextp">CHECK OUT</a></div>
				<% } %>				
				</td>
			</tr>
		</table>
		</td>
		<td width=20>&nbsp;</td>
	</tr>
</table>
<input type=hidden name=hdnOp>
<input type=hidden name=prod value="<%=product.getProductId()%>">
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
