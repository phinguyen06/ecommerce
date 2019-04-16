<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.WoodProduct"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.WoodProductDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="java.util.HashMap"%>

<%
String message = "";
WoodCategory[] categories = new WoodCategory[1];
WoodProduct[] products = new WoodProduct[1];
boolean hasCart = false;
String categoryTitle = "";
int catId = -1;
try
{	
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();
	if( request.getParameter("cat") != null )
	{
		catId = Integer.parseInt(request.getParameter("cat"));
		products = WoodDB.getWoodProduct(catId);
		session.setAttribute(Constants.s_PRODUCT,WoodProduct.productsToHash(products));
		categoryTitle = products[0].getCategory().getName();
	}
	else
	{
		products = WoodProductDataProvider.getInstance().getAllProducts();
		session.setAttribute(Constants.s_PRODUCT,WoodProduct.productsToHash(products));
		categoryTitle = "Hot Products";
	}

	if(request.getParameter("hdnCancelOrder") != null && "CANCELORDER".equals(request.getParameter("hdnCancelOrder")))
		CustomerSession.clearSession(session);
	
	//ALTER CART SESSION
	hasCart = session.getAttribute(Constants.s_CUSTOMER_CART) != null;
	String productId = request.getParameter("prod");
	if( productId != null && "ADD".equals(request.getParameter("hdnOp")) )
	{
		HashMap<String,WoodProduct> map = (HashMap) session.getAttribute(Constants.s_PRODUCT);
		WoodProduct product = (WoodProduct) map.get(productId);
		String item = request.getParameter("hdnItem");
		String prodQuantity = request.getParameter("txtQuantity_"+item);  //HOW TO KNOW WHAT QUANTITY TO PICK????
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
			//System.out.println("Session Quantity:"+order.getQuantity());
		}
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
	t.setCategoryId(catId);
	t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
	t.setPage("index");
	t.setClientId(request.getRemoteAddr());
	TrackerDataProvider.getInstance().addTracker(t);
}
catch(Exception ignore){}

%>

<script language="JavaScript" type="text/javascript" src="include/wood.js"></script>


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

<form name="frm" method="post" action="#" id="mainForm">
<center>
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0"
	style="border-collapse: collapse;" width="1024"
	style="background-image:url(/ebiz/wood/images/pageBackground.jpg); PADDING-BOTTOM: 100px; background-repeat: no-repeat; PADDING-LEFT: 0px ">
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
		<td width=10>&nbsp;</td>
		<td id="ctl00_centerColumn" style="vertical-align: top; "><br>
		<br>
		<h1 class="leftMenuFont"><%=categoryTitle%></h1>
		<table id="ctl00_pageContent_ctl00_resultsHeader" cellpadding="2"
			cellspacing="0" style="width: 100%">
			<tr>
				<td id="ctl00_pageContent_ctl00_resultCell" align=right>Displaying
				products 1 - <%=products.length%> of <%=products.length%> results</td>
			</tr>
		</table>
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			cellpadding="2" border="3" style="width: 100%; border-collapse: ">
			<tr>
				<th colspan=2 align=center>Product
				</td>
				<th align=center>Price
				</td>
				<th align=center>Quantity
				</td>
				<th align=center>Cart
				</td>
				<th align=center>Order
				</td>
			</tr>

			<% for(int i=0; i<products.length; i++ ) { %>
			<tr>
				<td width="100"><a
					href="giftItem.jsp?prod=<%=products[i].getProductId()%>"><img
					alt="<%=products[i].getName()%>"
					src="<%=products[i].getCategory().getUrlPath()+"s"+products[i].getImageName()%>"
					class="containerBody-img" /></a></td>
				<td>
				<h5><a href="giftItem.jsp?prod=<%=products[i].getProductId()%>"><%=products[i].getName()%></a>
				</h5>
				<%=products[i].getDescription()==null?"" : products[i].getDescription()%>
				</td>
				<td align=right><%=products[i].getPrice()%></td>
				<td><input name="txtQuantity_<%=i%>" type="text" value="1"
					maxlength="3" size="3" id="txtQuantity" /></td>
				<td><a id="btnAddToCart3"
					href="javascript:onAddToCart(<%=products[i].getProductId()%>,<%=i%>)"
					class="buttontextp"><b>ADD TO CART</b></a></td>
				<td>
					<% if( hasCart ) { %>
						<a id="btnAddToCart3" href="cartSummary.jsp"	class="buttontextp"><b>CHECKOUT</b></a>
					<% }else{ %>
							<b>CHECKOUT</b>
					<% } %>
				</td>
			</tr>
			<% } %>
		</table>
		</td>
		<td width=20>&nbsp;</td>
	</tr>
</table>

<input type=hidden name=hdnOp>
<input type=hidden name=prod>
<input type=hidden name=hdnItem>

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
