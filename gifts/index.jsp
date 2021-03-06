<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.WoodProduct"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.data.User"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.WoodProductDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="com.ebiz.cache.InitializeDataProviders"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="java.util.HashMap"%>

<%
String message = "";
WoodCategory[] categories = new WoodCategory[1];
WoodProduct[] products = new WoodProduct[1];
OrderWoodProduct[] ordersCart = null;
User user = null;
boolean hasCart = false;
String categoryTitle = "";
int catId = -1;
String pageBackground = "pageBackground6.jpg";
try
{	
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();
	if(categories == null || categories.length == 0)
	{
		InitializeDataProviders.init();
		categories = WoodCategoryDataProvider.getInstance().getAllCategories();
		if(categories == null || categories.length == 0)
			categories = new WoodCategory[0];
	}
	
	//Hack for now until figure out how web.xml works...
	//try{
	//	com.ebiz.cache.EcryptoDataProvider.getInstance();
	//}
	//catch(Exception ignore){
	//	InitializeDataProviders.init();
	//}
		
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
		if( products == null || products.length == 0 )
			products = new WoodProduct[0];
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
			ordersCart = CustomerSession.getOrders(cartMap);
			//System.out.println("Session Quantity:"+order.getQuantity());
		}
	}else{
		HashMap<String,OrderWoodProduct> map = (HashMap) session.getAttribute(Constants.s_CUSTOMER_CART);
		if( map != null && map.size() > 0 )
			ordersCart = CustomerSession.getOrders(map);
	}
	if( products != null && products.length < 8 ) 
		pageBackground = "pageBackground7.jpg";
	
	//login validation
	user = (User)session.getAttribute(Constants.s_LOGGIN);
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
<form name="frm" method="post" action="#" id="mainForm">
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
				<td width=73 background="images/menubg2a_f.gif" align=center>		
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Return Home" href="<%=Constants.s_PAGE_ROOT_WOOD%>"><font COLOR="black">&nbsp;&nbsp;Home&nbsp;&nbsp;</font></a>
				</td>
				<td width=1></td>
				<td width=108 background="images/menubg3a.gif" align=center>				
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="My Account" href="Logon.jsp"><font COLOR="white">My Account</font></a>
				</td>
				<td width=1></td>
				<td width=186 background="images/menubg4a.gif" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="View Cart and Checkout" href="cartSummary.jsp"><font COLOR="white">View Cart/Checkout</font></a>
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
	style="background-image:url(images/<%=pageBackground%>); PADDING-BOTTOM: 30px; background-repeat: no-repeat; PADDING-LEFT: 0px; border-collapse: collapse; ">
	<tr>
		<td width=10>&nbsp;</td>
		<td width="200" valign="top"><br>
		<br>
		<br>
		<table border="0" cellpadding="0" cellspacing="0" width="100%"
			style="background-image: url(images/sidemenubgxx.jpg); PADDING-BOTTOM: 100px; vertical-align: top; PADDING-LEFT: 0px; PADDING-RIGHT: 10px; PADDING-TOP: 0px">
			<tr>
				<td align=left><br>
				<br>
				<br> <!--<img src="images/shop.jpg" alt="Browse Categories" />-->
				<center>
				<h3 class="leftMenuTitleFont">Shop</h3>
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
		<td valign="top">
		<br><br>
		<h1 class="leftMenuTitleFont"><center><%=categoryTitle%></center></h1>
		<table cellpadding="2" cellspacing="0" style="width: 100%">
			<tr>
				<td id="ctl00_pageContent_ctl00_resultCell" align=right>Displaying
				products 1 - <%=products.length%> of <%=products.length%> results</td>
			</tr>
		</table>
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			cellpadding="2" border="3" style="width: 100%; border-collapse: " align=center>
			<tr bgcolor=white>
				<th colspan=2 align=center>Product
				</td>
				<th align=center>Price
				</td>
				<th align=center>Quantity
				</td>
				<th align=center>Cart
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
				<h5><a href="giftItem.jsp?prod=<%=products[i].getProductId()%>"><%=products[i].getName()%></a></h5>
				<br>
				<%=Math.round(products[i].getLength())%>"L x <%=Math.round(products[i].getWidth())%>"W x <%=Math.round(products[i].getHeight())%>"H
				</td>
				<td align=right><%=products[i].getPrice()%></td>
				<td align=center><input name="txtQuantity_<%=i%>" type="text" value="1" maxlength="3" size="1" id="txtQuantity" /></td>
				<td align=center nowrap><a href="javascript:onAddToCart(<%=products[i].getProductId()%>,<%=i%>)"
					class="buttontextp"><b>ADD TO CART</b></a></td>
			</tr>
			<% } //for loop %>
		</table>
<input type=hidden name=hdnOp>
<input type=hidden name=prod>
<input type=hidden name=hdnItem>
</form>			
		</td>
		<td width=20>&nbsp;</td>
		<td valign="top"><br><br><br>
<form name="frmLogon" method="post" action="<%=Constants.s_PAGE_ROOT%>servlet/LoginServlet">		
			<table cellspacing="0" cellpadding="0" border="0" align=right>
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
								<td align=center><b>&nbsp;$<%=com.ebiz.utils.Util.formatNumber(total, 2)%></b>
							</tr> 
							<tr>
								<td colspan=2 align=center><br><a id="btnAddToCart3" href="cartSummary.jsp" class="buttontextp"><b>CHECK OUT</b></a></td>
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
<input type=hidden name=hdnNextPage value="<%=Constants.s_PAGE_ROOT_WOOD%>index.jsp">			
</form>			
		</td>
		<td width=10>&nbsp;</td>
	</tr>
</table>
</center>
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
			<td class="containerFooter" align="center">� 2009 Power by eBizDeal.com</td>
		</tr>
	</tbody>
</table>
</center>
</body>
</html>
