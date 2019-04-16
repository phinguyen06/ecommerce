<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>

<%
String message = null;
WoodCategory[] categories = new WoodCategory[1];
try
{
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();	
	//do not allow customer to move forward if shopping cart is empty!
	if(session.getAttribute(Constants.s_LOGGIN) == null)
		throw new Exception("Your session is invalid.  Please login");
}	
catch(Exception ex)
{
	response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+"logon.jsp");
}
finally
{
}		
	

//add counter for page usages
try{
	Tracker t = new Tracker();
	t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
	t.setPage("orderSearch");
	t.setClientId(request.getRemoteAddr());
	TrackerDataProvider.getInstance().addTracker(t);
}
catch(Exception ignore){}

%>


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

<form name="frm" method="post" action="orderReview.jsp" id="mainForm">
<center>
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0"
	style="border-collapse: collapse;" width="1024"
	style="background-image:url(/ebiz/wood/images/pageBackground.jpg); PADDING-BOTTOM: 0px; background-repeat: no-repeat; PADDING-LEFT: 0px ">
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
	<% if( message != null ){  %>	
		<td colspan="2" align=center><h4><i><font color=red><%=message%></font></i></h4></td>
	<% }else{ %>
		<td colspan="2" align=left>	
		<h1 class="leftMenuFont"><center>Order Search</center></h1>
		<table id="search" cellspacing="0"
			cellpadding="2" border="3" style="width: 300; border-collapse: " align=center>
			<tr>
				<td align=center colspan=3>Order Number/Confirmation Number:</td>
				<td align=right><input type=text name="txtSearch"></td>			
			</tr>
		</table><br><br>
		<table cellspacing="0" cellpadding="2" border="0" align=center>
			<tr>
				<td>
					<b>
						<a id="btnCheckout" href="javascript: document.frm.submit();">SEARCH</a> 
					</b>		
				</td>
			</tr>
		</table>					
		</td>
	<% } //closing no product to show %>
		<td width=20>&nbsp;</td>
	</tr>
</table>
<br><br><br><br>

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
