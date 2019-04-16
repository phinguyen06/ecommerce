<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.Order"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Status"%>
<%@ page import="com.ebiz.db.OrderDB"%>
<%@ page import="com.ebiz.cache.StatusCodeDataProvider"%>
<%@ page import="java.util.HashMap"%>

<%
String message = null;
Order[] orders = null;
Status[] statuses = null;
try
{
	statuses = StatusCodeDataProvider.getInstance().getStatuses(true);
	orders = OrderDB.getOrderByStatus(statuses);
	HashMap<String,Order> map = new HashMap<String,Order>();
	for( int i=0; i<orders.length; i++ ){
		map.put(String.valueOf(orders[i].getOrderId()),orders[i]);
	}
	session.setAttribute(Constants.s_CUSTOMER_REVIEW_CART, map);
}	
catch(Exception ex)
{
	message = ex.getMessage();
}
finally
{
}		
	
%>

<script language=javascript>

</script>

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

<form name="frm" method="post" action="#" id="mainForm">
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
				<h3 class="leftMenuFont">Administrator</h3>
				</center>
				<ul>
					<li><a href="<%=Constants.s_PAGE_ROOT_ADMIN%>Orders.jsp">View Orders</a></li>
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
		<h1 class="leftMenuFont"><center>Order List</center></h1>
		<table cellspacing="0" cellpadding="2" border="0" style="width: 50%; border-collapse:">
			<tr>
				<th align=center>Status Code</th>
				<th>Status Description</th>
			</tr>
		<% for( int i=0; i<statuses.length; i++ ){ %>
			<tr>
				<td align=center><%=statuses[i].getCode()%></td>
				<td><%=statuses[i].getDescription()%></td>
			</tr>
		<% } %>
		</table>
		<table cellspacing="0" cellpadding="2" border="3" style="width: 100%; border-collapse: ">
			<tr bgcolor=#CCCCCC>
				<th align=center>Type</th>
				<th width=50 align=center>Order ID</th>
				<th width=50 align=center>Customer ID</th>
				<th width=50 align=center>Payment ID</th>
				<th width=50 align=center>Shipping ID</th>
				<th width=50 align=center>Status</th>
				<th width=100 align=center>Created Date</th>
				<th width=100 align=center>Update Date</th>
				<th align=center>Error Code</th>
				<th align=center>Error Message</th>
			</tr>
		<% for( int i=0; i<orders.length; i++ ){ %>
			<tr>
				<td align=center><%=orders[i].getProductType()%></td>
				<td align=right><a href="OrderWoodProducts.jsp?orderId=<%=orders[i].getOrderId()%>"><%=orders[i].getOrderId()%></a></td>
				<td align=right><a href="Customer.jsp?orderId=<%=orders[i].getOrderId()%>"><%=orders[i].getCustomer().getCustomerId()%></a></td>
				<td align=right><a href="Payment.jsp?orderId=<%=orders[i].getOrderId()%>"><%=orders[i].getPayment().getPaymentId()%></a></td>
				<td align=right><a href="Shipping.jsp?orderId=<%=orders[i].getOrderId()%>">Shipping</a></td>
				<td align=center><%=orders[i].getStatus()%></td>
				<td align=center><%=orders[i].getCreateDate()%></td>
				<td align=center><%=orders[i].getUpdateDate()==null ? "&nbsp;" : orders[i].getUpdateDate()%></td>
				<td><%=orders[i].getErrorCode()==null ? "&nbsp;" : orders[i].getErrorCode()%></td>
				<td><%=orders[i].getErrorMessage()==null ? "&nbsp;" : orders[i].getErrorMessage()%></td>
			</tr>
		<% } //close for loop %>
		</table>		
		</td>
	<% } %>
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
